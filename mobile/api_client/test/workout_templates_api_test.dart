import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for WorkoutTemplatesApi
void main() {
  final instance = StaytrainingApi().getWorkoutTemplatesApi();

  group(WorkoutTemplatesApi, () {
    // Criar modelo
    //
    // **Permissão:** `template.write`.
    //
    //Future<IdResponse> createWorkoutTemplate(CreateWorkoutTemplateRequest createWorkoutTemplateRequest) async
    test('test createWorkoutTemplate', () async {
      // TODO
    });

    // Obter modelo
    //
    // **Permissão:** `template.read`.
    //
    //Future<WorkoutTemplate> getWorkoutTemplateById(String id) async
    test('test getWorkoutTemplateById', () async {
      // TODO
    });

    // Listar modelos
    //
    // **Permissão:** `template.read`.
    //
    //Future<BuiltList<WorkoutTemplateListItem>> listWorkoutTemplates({ bool onlySystemDefaults }) async
    test('test listWorkoutTemplates', () async {
      // TODO
    });

  });
}
