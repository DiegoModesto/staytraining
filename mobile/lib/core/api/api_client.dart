import 'package:dio/dio.dart';

import '../auth/auth_service.dart';
import '../config/app_config.dart';

/// Thin Dio wrapper that attaches the bearer token to every request.
class ApiClient {
  ApiClient(this._auth) {
    dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      contentType: 'application/json',
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = _auth.accessToken;
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ));
  }

  final AuthService _auth;
  late final Dio dio;
}
