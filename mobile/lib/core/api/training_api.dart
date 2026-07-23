import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../models/models.dart';
import 'api_client.dart';

/// Typed access to the StayTraining Web.API (through the gateway).
class TrainingApi {
  TrainingApi(this._client);
  final ApiClient _client;

  static final _dateFmt = DateFormat('yyyy-MM-dd');

  // ----- Catalog -----
  Future<List<MuscleGroup>> listMuscleGroups() async {
    final r = await _client.dio.get('/api/v1/muscle-groups');
    return (r.data as List).map((e) => MuscleGroup.fromJson(e)).toList();
  }

  Future<List<Exercise>> listExercises({String? modalityId}) async {
    final r = await _client.dio.get('/api/v1/exercises',
        queryParameters: modalityId == null ? null : {'modalityId': modalityId});
    return (r.data as List).map((e) => Exercise.fromJson(e)).toList();
  }

  Future<Exercise> getExercise(String id) async {
    final r = await _client.dio.get('/api/v1/exercises/$id');
    return Exercise.fromJson(r.data);
  }

  // ----- Templates -----
  Future<List<Map<String, dynamic>>> listTemplates({bool? onlySystemDefaults}) async {
    final r = await _client.dio.get('/api/v1/workout-templates',
        queryParameters: onlySystemDefaults == null ? null : {'onlySystemDefaults': onlySystemDefaults});
    return (r.data as List).cast<Map<String, dynamic>>();
  }

  // ----- Workouts -----
  Future<List<WorkoutListItem>> listWorkouts({String? ownerStudentId}) async {
    final r = await _client.dio.get('/api/v1/workouts',
        queryParameters: ownerStudentId == null ? null : {'ownerStudentId': ownerStudentId});
    return (r.data as List).map((e) => WorkoutListItem.fromJson(e)).toList();
  }

  Future<Workout> getWorkout(String id) async {
    final r = await _client.dio.get('/api/v1/workouts/$id');
    return Workout.fromJson(r.data);
  }

  Future<String> createWorkout(Map<String, dynamic> body) async {
    final r = await _client.dio.post('/api/v1/workouts', data: body);
    return r.data['id'] as String;
  }

  Future<String> createWorkoutFromTemplate(String templateId, String ownerStudentId, {String? nameOverride}) async {
    final r = await _client.dio.post('/api/v1/workouts/from-template',
        data: {'templateId': templateId, 'ownerStudentId': ownerStudentId, 'nameOverride': nameOverride});
    return r.data['id'] as String;
  }

  Future<String> addWorkoutItem(String workoutId, Map<String, dynamic> item) async {
    final r = await _client.dio.post('/api/v1/workouts/$workoutId/items', data: item);
    return r.data['id'] as String;
  }

  Future<void> removeWorkoutItem(String workoutId, String itemId) =>
      _client.dio.delete('/api/v1/workouts/$workoutId/items/$itemId');

  // ----- Schedule -----
  Future<List<WeekScheduleItem>> getWeek(DateTime weekStart) async {
    final r = await _client.dio.get('/api/v1/schedule/week',
        queryParameters: {'weekStart': _dateFmt.format(weekStart)});
    return (r.data as List).map((e) => WeekScheduleItem.fromJson(e)).toList();
  }

  Future<String> scheduleWorkout(String workoutId, DateTime date) async {
    final r = await _client.dio.post('/api/v1/schedule',
        data: {'workoutId': workoutId, 'date': _dateFmt.format(date)});
    return r.data['id'] as String;
  }

  // ----- Sessions & notes -----
  Future<String> startSession(String workoutId) async {
    final r = await _client.dio.post('/api/v1/sessions', data: {'workoutId': workoutId});
    return r.data['id'] as String;
  }

  Future<void> upsertNote(String sessionId, Map<String, dynamic> body) =>
      _client.dio.put('/api/v1/sessions/$sessionId/notes', data: body);

  Future<void> completeSession(String sessionId, int? rating, String? comment) =>
      _client.dio.post('/api/v1/sessions/$sessionId/complete',
          data: {'completionRating': rating, 'overallComment': comment});

  Future<List<Map<String, dynamic>>> getAllNotes({String? exerciseId}) async {
    final r = await _client.dio.get('/api/v1/notes',
        queryParameters: exerciseId == null ? null : {'exerciseId': exerciseId});
    return (r.data as List).cast<Map<String, dynamic>>();
  }

  Future<WeeklyReport> getWeeklyReport(DateTime weekStart) async {
    final r = await _client.dio.get('/api/v1/reports/weekly',
        queryParameters: {'weekStart': _dateFmt.format(weekStart)});
    return WeeklyReport.fromJson(r.data);
  }

  // ----- Sync & devices -----
  Future<Map<String, dynamic>> pullChanges(DateTime? since) async {
    final r = await _client.dio.get('/api/v1/sync/pull',
        queryParameters: since == null ? null : {'since': since.toUtc().toIso8601String()});
    return r.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> pushSessions(List<Map<String, dynamic>> sessions) async {
    final r = await _client.dio.post('/api/v1/sync/sessions', data: {'sessions': sessions});
    return r.data as Map<String, dynamic>;
  }

  Future<void> registerDeviceToken(String token, int platform) =>
      _client.dio.post('/api/v1/devices/token', data: {'token': token, 'platform': platform});

  // ----- Profile / ficha (current user) -----
  Future<Profile> getMyProfile() async {
    final r = await _client.dio.get('/api/v1/profiles/me');
    return Profile.fromJson(r.data as Map<String, dynamic>);
  }

  Future<void> updateMyProfile({
    required String fullName,
    required String email,
    String? phone,
    String? emergencyPhone,
    required BloodType bloodType,
    int? heightCm,
    double? weightKg,
  }) =>
      _client.dio.put('/api/v1/profiles/me', data: {
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'emergencyPhone': emergencyPhone,
        'bloodType': bloodType.index,
        'heightCm': heightCm,
        'weightKg': weightKg,
      });

  /// Uploads an already cropped/resized image (bytes). Returns the presigned photo URL.
  Future<String> uploadMyPhoto(List<int> bytes, String fileName, String contentType) async {
    final form = FormData.fromMap({
      'file': MultipartFile.fromBytes(bytes, filename: fileName, contentType: DioMediaType.parse(contentType)),
    });
    final r = await _client.dio.post('/api/v1/profiles/me/photo', data: form);
    return (r.data as Map<String, dynamic>)['photoUrl'] as String;
  }

  Future<List<CatalogBodyPart>> listHealthCatalog() async {
    final r = await _client.dio.get('/api/v1/health-catalog');
    return (r.data as List).map((e) => CatalogBodyPart.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> addMyApportment(String bodyPartId, String problemTypeId, String? observation) =>
      _client.dio.post('/api/v1/profiles/me/apportments',
          data: {'bodyPartId': bodyPartId, 'problemTypeId': problemTypeId, 'observation': observation});

  Future<void> removeMyApportment(String apportmentId) =>
      _client.dio.delete('/api/v1/profiles/me/apportments/$apportmentId');
}
