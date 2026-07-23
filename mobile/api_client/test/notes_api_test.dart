import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for NotesApi
void main() {
  final instance = StaytrainingApi().getNotesApi();

  group(NotesApi, () {
    // Notas de execução da sessão
    //
    // **Permissão:** `workout.read`.
    //
    //Future<BuiltList<ExerciseNote>> getSessionNotes(String id) async
    test('test getSessionNotes', () async {
      // TODO
    });

    // Listar notas de execução
    //
    // Filtrável por aluno/exercício. **Permissão:** `report.read`.
    //
    //Future<BuiltList<ExerciseNote>> listNotes({ String studentId, String exerciseId }) async
    test('test listNotes', () async {
      // TODO
    });

  });
}
