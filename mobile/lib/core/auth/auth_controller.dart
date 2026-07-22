import 'package:flutter/foundation.dart';

import 'auth_service.dart';

/// App-wide authentication state. Extends [ChangeNotifier] so it can drive go_router redirects.
class AuthController extends ChangeNotifier {
  AuthController(this._service);
  final AuthService _service;

  bool _ready = false;
  bool _busy = false;
  String? _error;

  bool get isReady => _ready;
  bool get isBusy => _busy;
  bool get isAuthenticated => _service.isAuthenticated;
  String? get error => _error;

  Future<void> restore() async {
    await _service.restore();
    _ready = true;
    notifyListeners();
  }

  Future<bool> loginOidc() async {
    _busy = true;
    _error = null;
    notifyListeners();
    try {
      final ok = await _service.loginWithOidc();
      return ok;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _busy = false;
      notifyListeners();
    }
  }

  Future<void> loginManual(String token) async {
    await _service.setManualToken(token.trim());
    notifyListeners();
  }

  Future<void> logout() async {
    await _service.logout();
    notifyListeners();
  }
}
