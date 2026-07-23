import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:staytraining/core/auth/auth_service.dart';

class _MockDio extends Mock implements Dio {}

class _MockStorage extends Mock implements FlutterSecureStorage {}

Response<Map<String, dynamic>> _tokenResponse(Map<String, dynamic> body) => Response(
      requestOptions: RequestOptions(path: '/connect/token'),
      statusCode: 200,
      data: body,
    );

void main() {
  setUpAll(() => registerFallbackValue(Options()));

  late _MockDio dio;
  late _MockStorage storage;
  late AuthService service;

  setUp(() {
    dio = _MockDio();
    storage = _MockStorage();
    when(() => storage.write(key: any(named: 'key'), value: any(named: 'value'))).thenAnswer((_) async {});
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((_) async {});
    service = AuthService(http: dio, storage: storage);
  });

  group('login', () {
    test('stores tokens and authenticates on success', () async {
      when(() => dio.post<Map<String, dynamic>>(any(), data: any(named: 'data'), options: any(named: 'options')))
          .thenAnswer((_) async => _tokenResponse({'access_token': 'at-1', 'refresh_token': 'rt-1'}));

      final ok = await service.login('rita@example.com', 'secret');

      expect(ok, isTrue);
      expect(service.accessToken, 'at-1');
      expect(service.isAuthenticated, isTrue);
      verify(() => storage.write(key: 'access_token', value: 'at-1')).called(1);
      verify(() => storage.write(key: 'refresh_token', value: 'rt-1')).called(1);
    });

    test('returns false and does not authenticate on invalid credentials (400)', () async {
      when(() => dio.post<Map<String, dynamic>>(any(), data: any(named: 'data'), options: any(named: 'options')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/connect/token'),
        response: Response(requestOptions: RequestOptions(path: '/connect/token'), statusCode: 400),
      ));

      final ok = await service.login('rita@example.com', 'wrong');

      expect(ok, isFalse);
      expect(service.isAuthenticated, isFalse);
      verifyNever(() => storage.write(key: 'access_token', value: any(named: 'value')));
    });

    test('returns false when the response has no access token', () async {
      when(() => dio.post<Map<String, dynamic>>(any(), data: any(named: 'data'), options: any(named: 'options')))
          .thenAnswer((_) async => _tokenResponse({'token_type': 'Bearer'}));

      expect(await service.login('rita@example.com', 'secret'), isFalse);
    });
  });

  group('refresh', () {
    test('returns false and does not call the token endpoint without a refresh token', () async {
      when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async => null);

      expect(await service.refresh(), isFalse);
      verifyNever(() => dio.post<Map<String, dynamic>>(any(), data: any(named: 'data'), options: any(named: 'options')));
    });

    test('exchanges the refresh token and persists the new access token', () async {
      when(() => storage.read(key: 'refresh_token')).thenAnswer((_) async => 'rt-old');
      when(() => dio.post<Map<String, dynamic>>(any(), data: any(named: 'data'), options: any(named: 'options')))
          .thenAnswer((_) async => _tokenResponse({'access_token': 'at-2', 'refresh_token': 'rt-2'}));

      expect(await service.refresh(), isTrue);
      expect(service.accessToken, 'at-2');
      verify(() => storage.write(key: 'access_token', value: 'at-2')).called(1);
      verify(() => storage.write(key: 'refresh_token', value: 'rt-2')).called(1);
    });

    test('keeps the previous refresh token when the server returns none', () async {
      when(() => storage.read(key: 'refresh_token')).thenAnswer((_) async => 'rt-old');
      when(() => dio.post<Map<String, dynamic>>(any(), data: any(named: 'data'), options: any(named: 'options')))
          .thenAnswer((_) async => _tokenResponse({'access_token': 'at-2'}));

      expect(await service.refresh(), isTrue);
      verify(() => storage.write(key: 'refresh_token', value: 'rt-old')).called(1);
    });

    test('returns false when the exchange throws', () async {
      when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async => 'rt-old');
      when(() => dio.post<Map<String, dynamic>>(any(), data: any(named: 'data'), options: any(named: 'options')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '/connect/token')));

      expect(await service.refresh(), isFalse);
    });
  });
}
