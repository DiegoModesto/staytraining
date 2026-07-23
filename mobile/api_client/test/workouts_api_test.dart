import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for WorkoutsApi
void main() {
  final instance = StaytrainingApi().getWorkoutsApi();

  group(WorkoutsApi, () {
    // Adicionar exercício ao treino
    //
    // Corpo = item de prescrição. **Permissão:** `workout.write`.
    //
    //Future<IdResponse> addWorkoutItem(String id, WorkoutItemInput workoutItemInput) async
    test('test addWorkoutItem', () async {
      // TODO
    });

    // Criar treino
    //
    // Cria um treino do zero para um aluno. **Permissão:** `workout.write`.
    //
    //Future<IdResponse> createWorkout(CreateWorkoutRequest createWorkoutRequest) async
    test('test createWorkout', () async {
      // TODO
    });

    // Criar treino de um modelo
    //
    // **Permissão:** `workout.write`.
    //
    //Future<IdResponse> createWorkoutFromTemplate(CreateWorkoutFromTemplateRequest createWorkoutFromTemplateRequest) async
    test('test createWorkoutFromTemplate', () async {
      // TODO
    });

    // Excluir treino
    //
    // Soft-delete. **Permissão:** `workout.write`.
    //
    //Future deleteWorkout(String id) async
    test('test deleteWorkout', () async {
      // TODO
    });

    // Obter treino
    //
    // Detalhe com itens ordenados. **Permissão:** `workout.read`.
    //
    //Future<Workout> getWorkoutById(String id) async
    test('test getWorkoutById', () async {
      // TODO
    });

    // Listar treinos
    //
    // **Permissão:** `workout.read`.
    //
    //Future<BuiltList<WorkoutListItem>> listWorkouts({ String ownerStudentId }) async
    test('test listWorkouts', () async {
      // TODO
    });

    // Remover exercício do treino
    //
    // **Permissão:** `workout.write`.
    //
    //Future removeWorkoutItem(String id, String itemId) async
    test('test removeWorkoutItem', () async {
      // TODO
    });

    // Renomear treino
    //
    // **Permissão:** `workout.write`.
    //
    //Future renameWorkout(String id, NameRequest nameRequest) async
    test('test renameWorkout', () async {
      // TODO
    });

    // Reordenar itens
    //
    // **Permissão:** `workout.write`.
    //
    //Future reorderWorkoutItems(String id, ReorderWorkoutItemsRequest reorderWorkoutItemsRequest) async
    test('test reorderWorkoutItems', () async {
      // TODO
    });

  });
}
