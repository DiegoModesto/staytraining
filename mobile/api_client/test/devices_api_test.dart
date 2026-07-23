import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for DevicesApi
void main() {
  final instance = StaytrainingApi().getDevicesApi();

  group(DevicesApi, () {
    // Registrar token de push
    //
    // Registra o token de push (Platform: 0=Android, 1=iOS). Retorna **200**. *Autenticado.*
    //
    //Future<IdResponse> registerDeviceToken(RegisterDeviceTokenRequest registerDeviceTokenRequest) async
    test('test registerDeviceToken', () async {
      // TODO
    });

  });
}
