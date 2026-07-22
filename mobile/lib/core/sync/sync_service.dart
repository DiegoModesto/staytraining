import '../api/training_api.dart';
import '../db/local_store.dart';

/// Coordinates offline synchronization:
///  - pushes locally queued sessions/notes to the server;
///  - pulls server changes since the last watermark and caches them locally.
class SyncService {
  SyncService(this._api, this._store);
  final TrainingApi _api;
  final LocalStore _store;

  static const _lastSyncKey = 'sync.lastServerTime';
  static const _workoutsCacheKey = 'cache.workouts';

  /// Uploads any sessions recorded while offline. Safe to call repeatedly (idempotent server-side).
  Future<int> pushPending() async {
    final pending = await _store.pendingSessions();
    if (pending.isEmpty) return 0;

    final result = await _api.pushSessions(pending);
    final inserted = (result['sessionsInserted'] as int?) ?? 0;

    // Regardless of inserted/skipped, both mean the server now has them — clear the queue.
    await _store.clearPendingSessions(pending.map((s) => s['id'] as String));
    return inserted;
  }

  /// Pulls deltas since the last sync and caches the workout list locally.
  Future<void> pull() async {
    final lastRaw = await _store.getString(_lastSyncKey);
    final since = lastRaw == null ? null : DateTime.tryParse(lastRaw);

    final data = await _api.pullChanges(since);

    final serverTime = data['serverTime'] as String?;
    if (serverTime != null) {
      await _store.setString(_lastSyncKey, serverTime);
    }

    final workouts = data['workouts'];
    if (workouts is List && workouts.isNotEmpty) {
      await _store.setJson(_workoutsCacheKey, workouts);
    }
  }

  /// Full sync cycle: push local changes first, then pull server changes.
  Future<void> syncNow() async {
    await pushPending();
    await pull();
  }

  Future<List<dynamic>> cachedWorkouts() async =>
      (await _store.getJson<List<dynamic>>(_workoutsCacheKey)) ?? const [];
}
