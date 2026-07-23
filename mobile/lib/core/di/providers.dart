import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
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

/// Catálogo de exercícios carregado uma vez e mantido em cache: resolve `exerciseId → nome`
/// (e a modalidade), já que treinos/notas/relatório trazem só o id. `keepAlive` para não recarregar
/// a cada tela. Use `ref.watch(exerciseCatalogProvider)` e `.nameFor(id)`.
final exerciseCatalogProvider = FutureProvider<ExerciseCatalog>((ref) async {
  ref.keepAlive();
  final items = await ref.read(trainingApiProvider).listExercises();
  return ExerciseCatalog({for (final e in items) e.id: e});
});

/// Lookup imutável de exercícios por id.
class ExerciseCatalog {
  const ExerciseCatalog(this._byId);
  final Map<String, Exercise> _byId;

  Exercise? byId(String id) => _byId[id];

  /// Nome do exercício, com fallback amigável quando ainda não carregou / não encontrado.
  String nameFor(String id) => _byId[id]?.name ?? 'Exercício';

  int get length => _byId.length;
}
