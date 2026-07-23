import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../api/api_client.dart';
import '../api/training_api.dart';
import '../auth/auth_controller.dart';
import '../auth/auth_service.dart';
import '../db/local_store.dart';
import '../notifications/notification_service.dart';
import '../notifications/push_registration_service.dart';
import '../sync/sync_service.dart';
import '../theme/theme_controller.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authControllerProvider = ChangeNotifierProvider<AuthController>(
  (ref) => AuthController(ref.read(authServiceProvider)),
);

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient(
      ref.read(authServiceProvider),
      cache: ref.read(localStoreProvider),
      onAuthFailure: () => ref.read(authControllerProvider).logout(),
    ));

final trainingApiProvider = Provider<TrainingApi>((ref) => TrainingApi(ref.read(apiClientProvider)));

final localStoreProvider = Provider<LocalStore>((ref) => LocalStore());

final syncServiceProvider = Provider<SyncService>(
  (ref) => SyncService(ref.read(trainingApiProvider), ref.read(localStoreProvider)),
);

final notificationServiceProvider = Provider<NotificationService>((ref) => NotificationService());

/// App theme mode (Sistema/Claro/Escuro), persisted; defaults to following the OS.
final themeControllerProvider = ChangeNotifierProvider<ThemeController>(
  (ref) => ThemeController(ref.read(localStoreProvider)),
);

/// Registers the device push token with the backend. Uses a no-op token provider until Firebase
/// is wired in (see [PushRegistrationService]); the whole thing is gated by `PUSH_ENABLED`.
final pushRegistrationServiceProvider = Provider<PushRegistrationService>(
  (ref) => PushRegistrationService(ref.read(trainingApiProvider)),
);

/// Perguntas do aluno ao professor (com respostas). `ref.invalidate(myQuestionsProvider)` recarrega.
final myQuestionsProvider = FutureProvider<List<Question>>(
  (ref) => ref.read(trainingApiProvider).listMyQuestions(),
);

/// Perfil do usuário logado, carregado uma vez e mantido em cache (resolve offline via cache HTTP
/// do ApiClient). Usado, p.ex., para a saudação na home. `ref.invalidate` para forçar recarga.
final myProfileProvider = FutureProvider<Profile>((ref) async {
  ref.keepAlive();
  return ref.read(trainingApiProvider).getMyProfile();
});

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
