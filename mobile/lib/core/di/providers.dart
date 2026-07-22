import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../api/training_api.dart';
import '../auth/auth_controller.dart';
import '../auth/auth_service.dart';
import '../db/local_store.dart';
import '../notifications/notification_service.dart';
import '../sync/sync_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authControllerProvider = ChangeNotifierProvider<AuthController>(
  (ref) => AuthController(ref.read(authServiceProvider)),
);

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient(ref.read(authServiceProvider)));

final trainingApiProvider = Provider<TrainingApi>((ref) => TrainingApi(ref.read(apiClientProvider)));

final localStoreProvider = Provider<LocalStore>((ref) => LocalStore());

final syncServiceProvider = Provider<SyncService>(
  (ref) => SyncService(ref.read(trainingApiProvider), ref.read(localStoreProvider)),
);

final notificationServiceProvider = Provider<NotificationService>((ref) => NotificationService());
