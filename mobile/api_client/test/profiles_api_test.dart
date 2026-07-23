import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for ProfilesApi
void main() {
  final instance = StaytrainingApi().getProfilesApi();

  group(ProfilesApi, () {
    // Adicionar apontamento (aluno)
    //
    // O aluno adiciona um apontamento de saúde na própria ficha. *Autenticado.*
    //
    //Future<IdResponse> addMyApportment(AddApportmentRequest addApportmentRequest) async
    test('test addMyApportment', () async {
      // TODO
    });

    // Meu perfil
    //
    // Perfil do usuário atual. `isStudent` indica se é ficha de aluno. *Autenticado.*
    //
    //Future<Profile> getMyProfile() async
    test('test getMyProfile', () async {
      // TODO
    });

    // Remover apontamento (aluno)
    //
    // O aluno remove um apontamento da própria ficha. *Autenticado.*
    //
    //Future removeMyApportment(String id) async
    test('test removeMyApportment', () async {
      // TODO
    });

    // Atualizar meu perfil
    //
    // Atualiza os dados do próprio perfil. *Autenticado.*
    //
    //Future updateMyProfile(UpdateProfileRequest updateProfileRequest) async
    test('test updateMyProfile', () async {
      // TODO
    });

    // Enviar foto do perfil
    //
    // Multipart, imagem ≤ 2 MB. Guarda no storage e devolve URL pré-assinada. *Autenticado.*
    //
    //Future<UploadMyProfilePhoto200Response> uploadMyProfilePhoto({ MultipartFile file }) async
    test('test uploadMyProfilePhoto', () async {
      // TODO
    });

  });
}
