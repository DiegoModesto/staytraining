import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for ModalitiesApi
void main() {
  final instance = StaytrainingApi().getModalitiesApi();

  group(ModalitiesApi, () {
    // Criar modalidade
    //
    // **Permissão:** `modality.write`.
    //
    //Future<IdResponse> createModality(ModalityRequest modalityRequest) async
    test('test createModality', () async {
      // TODO
    });

    // Excluir modalidade
    //
    // Soft-delete. Bloqueado (409) se em uso. **Permissão:** `modality.write`.
    //
    //Future deleteModality(String id) async
    test('test deleteModality', () async {
      // TODO
    });

    // Listar modalidades
    //
    // **Permissão:** `modality.read`.
    //
    //Future<BuiltList<Modality>> listModalities() async
    test('test listModalities', () async {
      // TODO
    });

    // Atualizar modalidade
    //
    // **Permissão:** `modality.write`.
    //
    //Future updateModality(String id, ModalityRequest modalityRequest) async
    test('test updateModality', () async {
      // TODO
    });

  });
}
