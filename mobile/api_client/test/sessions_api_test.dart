import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for SessionsApi
void main() {
  final instance = StaytrainingApi().getSessionsApi();

  group(SessionsApi, () {
    // Concluir sessão
    //
    // **Permissão:** `session.write`.
    //
    //Future completeSession(String id, CompleteSessionRequest completeSessionRequest) async
    test('test completeSession', () async {
      // TODO
    });

    // Iniciar sessão
    //
    // Inicia a execução de um treino. **Permissão:** `session.write`.
    //
    //Future<IdResponse> startSession(StartSessionRequest startSessionRequest) async
    test('test startSession', () async {
      // TODO
    });

    // Registrar/atualizar nota de execução (upsert)
    //
    // Upsert da nota de um exercício na sessão. Retorna **200**. **Permissão:** `note.write`.
    //
    //Future<IdResponse> upsertExerciseNote(String id, UpsertExerciseNoteRequest upsertExerciseNoteRequest) async
    test('test upsertExerciseNote', () async {
      // TODO
    });

  });
}
