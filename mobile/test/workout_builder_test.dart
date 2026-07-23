import 'package:flutter_test/flutter_test.dart';
import 'package:staytraining/features/workouts/workout_builder_screen.dart';
import 'package:staytraining/models/models.dart';

Exercise _exercise({required bool aerobic}) => Exercise(
      id: aerobic ? 'ex-run' : 'ex-bench',
      name: aerobic ? 'Corrida' : 'Supino',
      modalityId: 'mod-1',
      modalityName: 'Musculação',
      primaryMuscleGroupId: 'mg-1',
      defaultSets: 4,
      defaultReps: 12,
      defaultRestSeconds: 90,
      isAerobic: aerobic,
      defaultWorkSeconds: aerobic ? 45 : null,
      defaultIntervalRestSeconds: aerobic ? 15 : null,
      defaultRounds: aerobic ? 10 : null,
    );

void main() {
  group('DraftWorkoutItem', () {
    test('fromExercise seeds strength prescription from the exercise defaults', () {
      final draft = DraftWorkoutItem.fromExercise(_exercise(aerobic: false));

      expect(draft.isInterval, isFalse);
      expect(draft.sets, 4);
      expect(draft.reps, 12);
      expect(draft.restSeconds, 90);
    });

    test('fromExercise seeds interval prescription for aerobic exercises', () {
      final draft = DraftWorkoutItem.fromExercise(_exercise(aerobic: true));

      expect(draft.isInterval, isTrue);
      expect(draft.workSeconds, 45);
      expect(draft.intervalRestSeconds, 15);
      expect(draft.rounds, 10);
    });

    test('toJson maps a strength item to the API contract with the given order', () {
      final json = DraftWorkoutItem.fromExercise(_exercise(aerobic: false)).toJson(2);

      expect(json['exerciseId'], 'ex-bench');
      expect(json['order'], 2);
      expect(json['sets'], 4);
      expect(json['reps'], 12);
      expect(json['restSeconds'], 90);
      expect(json['workSeconds'], isNull);
      expect(json['rounds'], isNull);
      expect(json['professorComment'], isNull);
    });

    test('toJson maps an interval item with sets=1/reps=0 and the work fields', () {
      final draft = DraftWorkoutItem.fromExercise(_exercise(aerobic: true))
        ..sectionLabel = 'Aquecimento';
      final json = draft.toJson(0);

      expect(json['sectionLabel'], 'Aquecimento');
      expect(json['sets'], 1);
      expect(json['reps'], 0);
      expect(json['workSeconds'], 45);
      expect(json['intervalRestSeconds'], 15);
      expect(json['rounds'], 10);
    });

    test('toJson falls back to safe defaults when prescription fields are cleared', () {
      final draft = DraftWorkoutItem(exercise: _exercise(aerobic: false), isInterval: false)
        ..sets = null
        ..reps = null
        ..restSeconds = null;
      final json = draft.toJson(0);

      expect(json['sets'], 3);
      expect(json['reps'], 10);
      expect(json['restSeconds'], 60);
    });
  });
}
