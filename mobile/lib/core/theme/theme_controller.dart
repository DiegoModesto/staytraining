import 'package:flutter/material.dart';

import '../db/local_store.dart';

/// App theme mode, defaulting to [ThemeMode.system] and overridable by the user. The choice is
/// persisted in [LocalStore] so it survives restarts.
class ThemeController extends ChangeNotifier {
  ThemeController(this._store) {
    _load();
  }

  static const _key = 'settings:themeMode';

  final LocalStore _store;

  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;

  Future<void> _load() async {
    final raw = await _store.getString(_key);
    final restored = _parse(raw);
    if (restored != _mode) {
      _mode = restored;
      notifyListeners();
    }
  }

  Future<void> setMode(ThemeMode mode) async {
    if (mode == _mode) return;
    _mode = mode;
    notifyListeners();
    await _store.setString(_key, mode.name);
  }

  static ThemeMode _parse(String? value) => switch (value) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
}
