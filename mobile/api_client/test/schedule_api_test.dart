import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for ScheduleApi
void main() {
  final instance = StaytrainingApi().getScheduleApi();

  group(ScheduleApi, () {
    // Agenda da semana
    //
    // **Permissão:** `workout.read`.
    //
    //Future<BuiltList<WeekScheduleItem>> getWeekSchedule(Date weekStart, { String studentId }) async
    test('test getWeekSchedule', () async {
      // TODO
    });

    // Agendar treino
    //
    // **Permissão:** `session.write`.
    //
    //Future<IdResponse> scheduleWorkout(ScheduleWorkoutRequest scheduleWorkoutRequest) async
    test('test scheduleWorkout', () async {
      // TODO
    });

  });
}
