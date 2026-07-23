import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for ExercisesApi
void main() {
  final instance = StaytrainingApi().getExercisesApi();

  group(ExercisesApi, () {
    // Anexar link do YouTube
    //
    // Anexa um link do YouTube como mídia. **Permissão:** `exercise.write`.
    //
    //Future<IdResponse> addExerciseYoutubeMedia(String id, AddExerciseYoutubeMediaRequest addExerciseYoutubeMediaRequest) async
    test('test addExerciseYoutubeMedia', () async {
      // TODO
    });

    // Criar exercício
    //
    // Cria um exercício. Modalidade e músculo primário são obrigatórios. **Permissão:** `exercise.write`.
    //
    //Future<IdResponse> createExercise(CreateExerciseRequest createExerciseRequest) async
    test('test createExercise', () async {
      // TODO
    });

    // Obter exercício
    //
    // Detalhe do exercício, com músculos, prescrição e mídias. **Permissão:** `exercise.read`.
    //
    //Future<Exercise> getExerciseById(String id) async
    test('test getExerciseById', () async {
      // TODO
    });

    // Listar exercícios
    //
    // Lista exercícios do tenant, opcionalmente por modalidade. **Permissão:** `exercise.read`.
    //
    //Future<BuiltList<ExerciseListItem>> listExercises({ String modalityId }) async
    test('test listExercises', () async {
      // TODO
    });

    // Enviar mídia (upload)
    //
    // Envia uma mídia (GIF/vídeo/imagem) via multipart; vai para o object storage. **Permissão:** `exercise.write`.
    //
    //Future<UploadExerciseMedia201Response> uploadExerciseMedia(String id, { MultipartFile file, ExerciseMediaKind kind }) async
    test('test uploadExerciseMedia', () async {
      // TODO
    });

  });
}
