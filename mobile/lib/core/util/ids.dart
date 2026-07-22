import 'dart:math';

final _rng = Random.secure();

/// Generates a RFC-4122 v4 GUID string (used for offline-created session/note ids).
String newGuid() {
  final b = List<int>.generate(16, (_) => _rng.nextInt(256));
  b[6] = (b[6] & 0x0f) | 0x40; // version 4
  b[8] = (b[8] & 0x3f) | 0x80; // variant
  String hex(int i) => b[i].toRadixString(16).padLeft(2, '0');
  final s = List.generate(16, hex).join();
  return '${s.substring(0, 8)}-${s.substring(8, 12)}-${s.substring(12, 16)}-'
      '${s.substring(16, 20)}-${s.substring(20)}';
}
