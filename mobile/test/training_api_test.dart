import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:staytraining/core/api/api_client.dart';
import 'package:staytraining/core/api/training_api.dart';
import 'package:staytraining/core/di/providers.dart';
import 'package:staytraining/models/models.dart';

class _MockApiClient extends Mock implements ApiClient {}

class _MockDio extends Mock implements Dio {}

Response<dynamic> _resp(String path, dynamic data) =>
    Response<dynamic>(requestOptions: RequestOptions(path: path), data: data, statusCode: 200);

void main() {
  late _MockDio dio;
  late _MockApiClient client;
  late TrainingApi api;

  setUp(() {
    dio = _MockDio();
    client = _MockApiClient();
    when(() => client.dio).thenReturn(dio);
    api = TrainingApi(client);
  });

  test('listModalities parses the array', () async {
    when(() => dio.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer(
      (_) async => _resp('/api/v1/modalities', [
        {'id': 'm1', 'name': 'Boxe', 'colorHex': '#FF4757', 'isIntervalBased': true},
      ]),
    );

    final result = await api.listModalities();
    expect(result, hasLength(1));
    expect(result.single.name, 'Boxe');
    expect(result.single.isIntervalBased, isTrue);
  });

  test('listWorkouts maps to typed items', () async {
    when(() => dio.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer(
      (_) async => _resp('/api/v1/workouts', [
        {'id': 'w1', 'name': 'Treino A', 'modalityName': 'Musculação', 'itemCount': 6},
      ]),
    );

    final result = await api.listWorkouts();
    expect(result.single.name, 'Treino A');
    expect(result.single.itemCount, 6);
  });

  test('getMyProfile parses the profile object', () async {
    when(() => dio.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer(
      (_) async => _resp('/api/v1/profiles/me', {
        'isStudent': true,
        'fullName': 'Rita Sibele',
        'email': 'rita@x.com',
        'bloodType': 7,
        'apportments': [],
      }),
    );

    final p = await api.getMyProfile();
    expect(p.isStudent, isTrue);
    expect(p.fullName, 'Rita Sibele');
    expect(p.bloodType, BloodType.oPositive);
  });

  test('createWorkoutFromTemplate posts the body and returns the new id', () async {
    when(() => dio.post(any(), data: any(named: 'data'))).thenAnswer(
      (_) async => _resp('/api/v1/workouts/from-template', {'id': 'w-new'}),
    );

    final id = await api.createWorkoutFromTemplate('t1', '00000000-0000-0000-0000-000000000000');
    expect(id, 'w-new');

    final captured = verify(() => dio.post('/api/v1/workouts/from-template', data: captureAny(named: 'data')))
        .captured
        .single as Map<String, dynamic>;
    expect(captured['templateId'], 't1');
  });

  group('ExerciseCatalog', () {
    test('resolves names by id with a friendly fallback', () {
      final catalog = ExerciseCatalog({
        'ex1': Exercise.fromJson({
          'id': 'ex1',
          'name': 'Supino reto',
          'modalityId': 'm1',
          'modalityName': 'Musculação',
          'primaryMuscleGroupId': 'mg1',
          'isAerobic': false,
        }),
      });

      expect(catalog.nameFor('ex1'), 'Supino reto');
      expect(catalog.nameFor('desconhecido'), 'Exercício');
      expect(catalog.byId('ex1'), isNotNull);
      expect(catalog.length, 1);
    });
  });

  test('askQuestion posts the payload and returns the new id', () async {
    when(() => dio.post(any(), data: any(named: 'data')))
        .thenAnswer((_) async => _resp('/api/v1/questions', {'id': 'q1'}));

    final id = await api.askQuestion(workoutId: 'w1', text: 'Dúvida');

    expect(id, 'q1');
    final captured = verify(() => dio.post('/api/v1/questions', data: captureAny(named: 'data')))
        .captured
        .single as Map<String, dynamic>;
    expect(captured['workoutId'], 'w1');
    expect(captured['exerciseId'], isNull);
    expect(captured['text'], 'Dúvida');
  });

  test('listMyQuestions parses questions with answers', () async {
    when(() => dio.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer(
      (_) async => _resp('/api/v1/questions/mine', [
        {
          'id': 'q1',
          'studentId': 'u1',
          'studentName': 'Rita',
          'workoutId': 'w1',
          'workoutName': 'Treino A',
          'text': 'Posso trocar?',
          'createdAt': '2026-07-23T10:00:00Z',
          'answerText': 'Pode sim',
          'answeredByName': 'Diego',
          'answeredAt': '2026-07-23T11:00:00Z',
          'isAnswered': true,
        },
      ]),
    );

    final result = await api.listMyQuestions();
    expect(result.single.about, 'Treino: Treino A');
    expect(result.single.isAnswered, isTrue);
    expect(result.single.answerText, 'Pode sim');
  });
}
