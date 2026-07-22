/// Runtime configuration. Override via --dart-define at build/run time, e.g.:
///   flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5200 \
///               --dart-define=AUTH_ISSUER=http://10.0.2.2:5100 \
///               --dart-define=AUTH_CLIENT_ID=mobile-app
class AppConfig {
  /// Gateway base URL (routes /api/v1/* to the Web.API).
  /// 10.0.2.2 is the Android emulator's alias for the host machine.
  static const String apiBaseUrl =
      String.fromEnvironment('API_BASE_URL', defaultValue: 'http://10.0.2.2:5200');

  /// Auth.API (OpenIddict) issuer for OIDC login.
  static const String authIssuer =
      String.fromEnvironment('AUTH_ISSUER', defaultValue: 'http://10.0.2.2:5100');

  static const String authClientId =
      String.fromEnvironment('AUTH_CLIENT_ID', defaultValue: 'mobile-app');

  static const String authRedirectUri =
      String.fromEnvironment('AUTH_REDIRECT_URI', defaultValue: 'com.staytraining.app://oauth');

  static const List<String> authScopes = ['openid', 'profile', 'offline_access', 'api:web'];

  /// Days without doing a scheduled workout before the local "pending" reminder fires.
  static const int pendingWorkoutDays = 3;
}
