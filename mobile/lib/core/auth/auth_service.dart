import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/app_config.dart';

/// Handles authentication via the OpenIddict **password grant** (email + password) against
/// Auth.API, persisting the opaque access/refresh tokens in secure storage. Tokens are renewed
/// silently with the refresh token (see [refresh]).
class AuthService {
  AuthService({Dio? http, FlutterSecureStorage? storage})
      : _http = http ?? Dio(BaseOptions(baseUrl: AppConfig.authIssuer)),
        _storage = storage ?? const FlutterSecureStorage();

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _tokenPath = '/connect/token';

  final Dio _http;
  final FlutterSecureStorage _storage;

  String? _accessToken;
  String? get accessToken => _accessToken;
  bool get isAuthenticated => _accessToken != null && _accessToken!.isNotEmpty;

  Future<void> restore() async {
    _accessToken = await _storage.read(key: _accessTokenKey);
  }

  /// Signs in with email + password. Returns true on success; false for invalid credentials or
  /// any error (network, server). Never throws.
  Future<bool> login(String email, String password) async {
    try {
      final response = await _http.post<Map<String, dynamic>>(
        _tokenPath,
        data: {
          'grant_type': 'password',
          'username': email.trim(),
          'password': password,
          'client_id': AppConfig.authClientId,
          'scope': AppConfig.authScopes.join(' '),
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      final token = response.data?['access_token'] as String?;
      if (token == null || token.isEmpty) return false;
      await _persist(token, response.data?['refresh_token'] as String?);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Exchanges the stored refresh token for a new access token (silent refresh).
  /// Returns false when there is no refresh token or the exchange fails.
  Future<bool> refresh() async {
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    if (refreshToken == null || refreshToken.isEmpty) return false;
    try {
      final response = await _http.post<Map<String, dynamic>>(
        _tokenPath,
        data: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
          'client_id': AppConfig.authClientId,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      final token = response.data?['access_token'] as String?;
      if (token == null || token.isEmpty) return false;
      await _persist(token, response.data?['refresh_token'] as String? ?? refreshToken);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> logout() async {
    _accessToken = null;
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<void> _persist(String accessToken, String? refreshToken) async {
    _accessToken = accessToken;
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }
}
