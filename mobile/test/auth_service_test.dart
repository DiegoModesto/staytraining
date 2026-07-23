import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:staytraining/core/auth/auth_service.dart';

class _MockAppAuth extends Mock implements FlutterAppAuth {}

class _MockStorage extends Mock implements FlutterSecureStorage {}

void main() {
  setUpAll(() => registerFallbackValue(TokenRequest('client', 'redirect', issuer: 'https://issuer')));

  late _MockAppAuth appAuth;
  late _MockStorage storage;
  late AuthService service;

  setUp(() {
    appAuth = _MockAppAuth();
    storage = _MockStorage();
    when(() => storage.write(key: any(named: 'key'), value: any(named: 'value'))).thenAnswer((_) async {});
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((_) async {});
    service = AuthService(appAuth: appAuth, storage: storage);
  });

  test('refresh returns false and does not call the IdP when there is no refresh token', () async {
    when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async => null);

    expect(await service.refresh(), isFalse);
    verifyNever(() => appAuth.token(any()));
  });

  test('refresh exchanges the refresh token and persists the new access token', () async {
    when(() => storage.read(key: 'refresh_token')).thenAnswer((_) async => 'rt-old');
    when(() => appAuth.token(any())).thenAnswer(
      (_) async => TokenResponse('new-access', 'new-refresh', null, null, null, null, null),
    );

    final ok = await service.refresh();

    expect(ok, isTrue);
    expect(service.accessToken, 'new-access');
    expect(service.isAuthenticated, isTrue);
    verify(() => storage.write(key: 'access_token', value: 'new-access')).called(1);
    verify(() => storage.write(key: 'refresh_token', value: 'new-refresh')).called(1);
  });

  test('refresh keeps the previous refresh token when the IdP returns none', () async {
    when(() => storage.read(key: 'refresh_token')).thenAnswer((_) async => 'rt-old');
    when(() => appAuth.token(any())).thenAnswer(
      (_) async => TokenResponse('new-access', null, null, null, null, null, null),
    );

    expect(await service.refresh(), isTrue);
    verify(() => storage.write(key: 'refresh_token', value: 'rt-old')).called(1);
  });

  test('refresh returns false when the token exchange throws', () async {
    when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async => 'rt-old');
    when(() => appAuth.token(any())).thenThrow(Exception('network down'));

    expect(await service.refresh(), isFalse);
  });
}
