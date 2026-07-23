import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for MuscleGroupsApi
void main() {
  final instance = StaytrainingApi().getMuscleGroupsApi();

  group(MuscleGroupsApi, () {
    // Criar grupo muscular
    //
    // **Permissão:** `muscle.write`.
    //
    //Future<IdResponse> createMuscleGroup(MuscleGroupRequest muscleGroupRequest) async
    test('test createMuscleGroup', () async {
      // TODO
    });

    // Excluir grupo muscular
    //
    // Soft-delete. Bloqueado (409) se em uso por exercícios. **Permissão:** `muscle.write`.
    //
    //Future deleteMuscleGroup(String id) async
    test('test deleteMuscleGroup', () async {
      // TODO
    });

    // Listar grupos musculares
    //
    // Lista os grupos musculares. **Permissão:** `exercise.read`.
    //
    //Future<BuiltList<MuscleGroup>> listMuscleGroups() async
    test('test listMuscleGroups', () async {
      // TODO
    });

    // Atualizar grupo muscular
    //
    // **Permissão:** `muscle.write`.
    //
    //Future updateMuscleGroup(String id, MuscleGroupRequest muscleGroupRequest) async
    test('test updateMuscleGroup', () async {
      // TODO
    });

  });
}
