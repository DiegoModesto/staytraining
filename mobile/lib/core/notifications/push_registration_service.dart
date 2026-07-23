import 'dart:io';

import '../api/training_api.dart';
import '../config/app_config.dart';

/// Supplies this device's push token (e.g. an FCM registration token). The default implementation
/// returns null, so push stays inert until a real provider — backed by `firebase_messaging` — is
/// plugged in. See mobile/README.md for the Firebase wiring steps.
abstract class PushTokenProvider {
  Future<String?> getToken();
}

/// No-op provider used until Firebase is configured.
class NoopPushTokenProvider implements PushTokenProvider {
  const NoopPushTokenProvider();

  @override
  Future<String?> getToken() async => null;
}

/// Registers the device push token with the backend so the server can deliver notifications.
///
/// Gated by [AppConfig.pushEnabled] — a no-op until both the flag is on and a [PushTokenProvider]
/// yields a token. Safe to call on every login / app resume: it only re-posts when the token
/// changes, and failures are swallowed so registration never blocks the app.
class PushRegistrationService {
  PushRegistrationService(
    this._api, {
    PushTokenProvider? tokenProvider,
    bool? enabled,
  })  : _tokenProvider = tokenProvider ?? const NoopPushTokenProvider(),
        _enabled = enabled ?? AppConfig.pushEnabled;

  final TrainingApi _api;
  final PushTokenProvider _tokenProvider;
  final bool _enabled;

  String? _lastRegistered;

  Future<void> register() async {
    if (!_enabled) return;
    final token = await _tokenProvider.getToken();
    if (token == null || token.isEmpty || token == _lastRegistered) return;

    // Matches Domain.Devices.DevicePlatform: Android = 0, Ios = 1.
    final platform = Platform.isIOS ? 1 : 0;
    try {
      await _api.registerDeviceToken(token, platform);
      _lastRegistered = token;
    } catch (_) {
      // Best-effort: a failed registration must not surface to the user.
    }
  }

  /// Forgets the last registered token so a subsequent [register] re-posts (call on logout).
  void reset() => _lastRegistered = null;
}
