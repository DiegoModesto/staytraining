import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/app_config.dart';

/// Handles authentication: OIDC (Authorization Code + PKCE) against Auth.API, with the
/// access token persisted in secure storage. A dev fallback lets you paste a token directly.
class AuthService {
  AuthService({FlutterAppAuth? appAuth, FlutterSecureStorage? storage})
      : _appAuth = appAuth ?? const FlutterAppAuth(),
        _storage = storage ?? const FlutterSecureStorage();

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final FlutterAppAuth _appAuth;
  final FlutterSecureStorage _storage;

  String? _accessToken;
  String? get accessToken => _accessToken;
  bool get isAuthenticated => _accessToken != null && _accessToken!.isNotEmpty;

  Future<void> restore() async {
    _accessToken = await _storage.read(key: _accessTokenKey);
  }

  /// Interactive OIDC login. Returns true on success.
  Future<bool> loginWithOidc() async {
    final result = await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        AppConfig.authClientId,
        AppConfig.authRedirectUri,
        issuer: AppConfig.authIssuer,
        scopes: AppConfig.authScopes,
        promptValues: ['login'],
        allowInsecureConnections: AppConfig.authAllowInsecure,
      ),
    );
    final token = result.accessToken;
    if (token == null) return false;
    await _persist(token, result.refreshToken);
    return true;
  }

  /// Exchanges the stored refresh token for a new access token (silent refresh).
  /// Returns false when there is no refresh token (e.g. dev manual token) or the exchange fails.
  Future<bool> refresh() async {
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    if (refreshToken == null || refreshToken.isEmpty) return false;
    try {
      final result = await _appAuth.token(
        TokenRequest(
          AppConfig.authClientId,
          AppConfig.authRedirectUri,
          issuer: AppConfig.authIssuer,
          refreshToken: refreshToken,
          scopes: AppConfig.authScopes,
          grantType: 'refresh_token',
          allowInsecureConnections: AppConfig.authAllowInsecure,
        ),
      );
      final token = result.accessToken;
      if (token == null) return false;
      await _persist(token, result.refreshToken ?? refreshToken);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Dev/testing fallback: store a bearer token obtained out-of-band.
  Future<void> setManualToken(String token) => _persist(token, null);

  Future<void> logout() async {
    _accessToken = null;
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<void> _persist(String accessToken, String? refreshToken) async {
    _accessToken = accessToken;
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }
}
