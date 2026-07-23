import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for SyncApi
void main() {
  final instance = StaytrainingApi().getSyncApi();

  group(SyncApi, () {
    // Pull de mudanças (delta)
    //
    // Puxa mudanças desde `since`. Sem `since`, devolve tudo. **Permissão:** `workout.read`.
    //
    //Future<SyncPullResponse> syncPull({ DateTime since }) async
    test('test syncPull', () async {
      // TODO
    });

    // Push de sessões executadas
    //
    // Envia sessões offline (idempotente por id). **Permissão:** `session.write`.
    //
    //Future<SyncPushResult> syncPushSessions(SyncPushSessionsRequest syncPushSessionsRequest) async
    test('test syncPushSessions', () async {
      // TODO
    });

  });
}
