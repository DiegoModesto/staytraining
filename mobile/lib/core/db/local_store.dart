import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Offline store (sqflite). A generic key/value cache plus a queue of workout sessions
/// recorded offline, pushed to the server on the next sync.
class LocalStore {
  Database? _db;

  Future<Database> _open() async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'staytraining.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE cache (key TEXT PRIMARY KEY, value TEXT NOT NULL)');
        await db.execute(
            'CREATE TABLE pending_sessions (id TEXT PRIMARY KEY, payload TEXT NOT NULL, created_at TEXT NOT NULL)');
      },
    );
    return _db!;
  }

  Future<void> setString(String key, String value) async {
    final db = await _open();
    await db.insert('cache', {'key': key, 'value': value},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getString(String key) async {
    final db = await _open();
    final rows = await db.query('cache', where: 'key = ?', whereArgs: [key], limit: 1);
    return rows.isEmpty ? null : rows.first['value'] as String;
  }

  Future<void> setJson(String key, Object value) => setString(key, jsonEncode(value));

  /// Wipes the key/value cache (HTTP responses etc.). Called on logout so a new login starts fresh.
  Future<void> clearCache() async {
    final db = await _open();
    await db.delete('cache');
  }

  Future<T?> getJson<T>(String key) async {
    final raw = await getString(key);
    return raw == null ? null : jsonDecode(raw) as T;
  }

  // ----- HTTP response cache (offline-first reads) -----
  // Stores the raw JSON body of successful GETs, keyed by request URI, so screens fall back to the
  // last-known data when the device is offline. Values may be a List or a Map.

  Future<void> cacheHttpResponse(String uriKey, Object? data) =>
      setString('http:$uriKey', jsonEncode(data));

  Future<Object?> readHttpResponse(String uriKey) async {
    final raw = await getString('http:$uriKey');
    return raw == null ? null : jsonDecode(raw);
  }

  // ----- Offline session queue -----

  Future<void> enqueueSession(Map<String, dynamic> session) async {
    final db = await _open();
    await db.insert(
      'pending_sessions',
      {
        'id': session['id'] as String,
        'payload': jsonEncode(session),
        'created_at': DateTime.now().toUtc().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> pendingSessions() async {
    final db = await _open();
    final rows = await db.query('pending_sessions', orderBy: 'created_at');
    return rows.map((r) => jsonDecode(r['payload'] as String) as Map<String, dynamic>).toList();
  }

  Future<void> clearPendingSessions(Iterable<String> ids) async {
    final db = await _open();
    final batch = db.batch();
    for (final id in ids) {
      batch.delete('pending_sessions', where: 'id = ?', whereArgs: [id]);
    }
    await batch.commit(noResult: true);
  }
}
