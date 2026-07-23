import 'dart:io';

import 'package:dio/dio.dart';

import '../auth/auth_service.dart';
import '../config/app_config.dart';
import '../db/local_store.dart';

/// Dio wrapper for the StayTraining API. Responsibilities:
///  - attaches the bearer token to every request;
///  - offline-first: caches successful GET bodies and serves them on connection errors;
///  - silent token refresh: on 401, refreshes the access token once and retries; on failure
///    invokes [onAuthFailure] (the app logs the user out).
class ApiClient {
  ApiClient(this._auth, {LocalStore? cache, void Function()? onAuthFailure})
      : _cache = cache,
        _onAuthFailure = onAuthFailure {
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
      onResponse: (response, handler) async {
        // Cache successful GET bodies for offline reads.
        if (_cache != null &&
            response.requestOptions.method == 'GET' &&
            response.statusCode == 200 &&
            response.data != null) {
          await _cache.cacheHttpResponse(response.requestOptions.uri.toString(), response.data);
        }
        handler.next(response);
      },
      onError: (e, handler) async {
        final options = e.requestOptions;

        // 1) 401 → single silent refresh, then retry the original request once.
        if (e.response?.statusCode == 401 && options.extra['retried'] != true) {
          final refreshed = await _refreshOnce();
          if (refreshed) {
            options.extra['retried'] = true;
            final token = _auth.accessToken;
            if (token != null) options.headers['Authorization'] = 'Bearer $token';
            try {
              return handler.resolve(await dio.fetch<dynamic>(options));
            } on DioException catch (retryError) {
              return handler.next(retryError);
            }
          }
          _onAuthFailure?.call();
          return handler.next(e);
        }

        // 2) Offline → serve the cached GET body if we have one.
        if (_cache != null && options.method == 'GET' && _isOffline(e)) {
          final cached = await _cache.readHttpResponse(options.uri.toString());
          if (cached != null) {
            return handler.resolve(Response<dynamic>(
              requestOptions: options,
              data: cached,
              statusCode: 200,
              extra: {'fromCache': true},
            ));
          }
        }

        handler.next(e);
      },
    ));
  }

  final AuthService _auth;
  final LocalStore? _cache;
  final void Function()? _onAuthFailure;

  late final Dio dio;

  // Single-flight refresh so concurrent 401s trigger only one token exchange.
  Future<bool>? _refreshing;
  Future<bool> _refreshOnce() =>
      _refreshing ??= _auth.refresh().whenComplete(() => _refreshing = null);

  static bool _isOffline(DioException e) =>
      e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.error is SocketException;
}
