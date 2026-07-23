import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for HealthCatalogApi
void main() {
  final instance = StaytrainingApi().getHealthCatalogApi();

  group(HealthCatalogApi, () {
    // Criar parte do corpo
    //
    // **Permissão:** `healthcatalog.write`.
    //
    //Future<IdResponse> createBodyPart(NameRequest nameRequest) async
    test('test createBodyPart', () async {
      // TODO
    });

    // Criar tipo de problema
    //
    // **Permissão:** `healthcatalog.write`.
    //
    //Future<IdResponse> createProblemType(CreateProblemTypeRequest createProblemTypeRequest) async
    test('test createProblemType', () async {
      // TODO
    });

    // Excluir parte do corpo
    //
    // Bloqueado (409) se houver apontamentos. **Permissão:** `healthcatalog.write`.
    //
    //Future deleteBodyPart(String id) async
    test('test deleteBodyPart', () async {
      // TODO
    });

    // Excluir tipo de problema
    //
    // Bloqueado (409) se referenciado por apontamentos. **Permissão:** `healthcatalog.write`.
    //
    //Future deleteProblemType(String id) async
    test('test deleteProblemType', () async {
      // TODO
    });

    // Listar catálogo de saúde
    //
    // Partes do corpo com seus tipos de problema. **Permissão:** `healthcatalog.read`.
    //
    //Future<BuiltList<BodyPart>> getHealthCatalog() async
    test('test getHealthCatalog', () async {
      // TODO
    });

    // Renomear parte do corpo
    //
    // **Permissão:** `healthcatalog.write`.
    //
    //Future updateBodyPart(String id, NameRequest nameRequest) async
    test('test updateBodyPart', () async {
      // TODO
    });

    // Renomear tipo de problema
    //
    // **Permissão:** `healthcatalog.write`.
    //
    //Future updateProblemType(String id, NameRequest nameRequest) async
    test('test updateProblemType', () async {
      // TODO
    });

  });
}
