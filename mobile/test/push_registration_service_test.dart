import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:staytraining/core/api/training_api.dart';
import 'package:staytraining/core/notifications/push_registration_service.dart';

class _MockApi extends Mock implements TrainingApi {}

class _FakeTokenProvider implements PushTokenProvider {
  _FakeTokenProvider(this.token);
  String? token;

  @override
  Future<String?> getToken() async => token;
}

void main() {
  late _MockApi api;

  setUp(() {
    api = _MockApi();
    when(() => api.registerDeviceToken(any(), any())).thenAnswer((_) async {});
  });

  test('does nothing when push is disabled', () async {
    final service = PushRegistrationService(api, tokenProvider: _FakeTokenProvider('fcm'), enabled: false);

    await service.register();

    verifyNever(() => api.registerDeviceToken(any(), any()));
  });

  test('does nothing when the token provider yields no token', () async {
    final service = PushRegistrationService(api, tokenProvider: _FakeTokenProvider(null), enabled: true);

    await service.register();

    verifyNever(() => api.registerDeviceToken(any(), any()));
  });

  test('registers the token with the backend when enabled', () async {
    final service = PushRegistrationService(api, tokenProvider: _FakeTokenProvider('fcm-123'), enabled: true);

    await service.register();

    verify(() => api.registerDeviceToken('fcm-123', any())).called(1);
  });

  test('does not re-register the same token on subsequent calls', () async {
    final service = PushRegistrationService(api, tokenProvider: _FakeTokenProvider('fcm-123'), enabled: true);

    await service.register();
    await service.register();

    verify(() => api.registerDeviceToken('fcm-123', any())).called(1);
  });

  test('registers again after the token changes', () async {
    final provider = _FakeTokenProvider('fcm-a');
    final service = PushRegistrationService(api, tokenProvider: provider, enabled: true);

    await service.register();
    provider.token = 'fcm-b';
    await service.register();

    verify(() => api.registerDeviceToken('fcm-a', any())).called(1);
    verify(() => api.registerDeviceToken('fcm-b', any())).called(1);
  });

  test('reset lets the same token register again (e.g. after logout/login)', () async {
    final service = PushRegistrationService(api, tokenProvider: _FakeTokenProvider('fcm-123'), enabled: true);

    await service.register();
    service.reset();
    await service.register();

    verify(() => api.registerDeviceToken('fcm-123', any())).called(2);
  });
}
