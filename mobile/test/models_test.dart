import 'package:flutter_test/flutter_test.dart';
import 'package:staytraining/models/models.dart';

void main() {
  group('Exercise.fromJson', () {
    test('parses full detail incl. media and modality', () {
      final e = Exercise.fromJson({
        'id': 'ex1',
        'name': 'Supino reto',
        'description': 'Empurrar',
        'modalityId': 'm1',
        'modalityName': 'Musculação',
        'primaryMuscleGroupId': 'mg1',
        'isAerobic': false,
        'defaultSets': 4,
        'defaultReps': 10,
        'defaultRestSeconds': 90,
        'media': [
          {'id': 'me1', 'kind': 2, 'url': 'https://youtu.be/x'},
        ],
      });

      expect(e.name, 'Supino reto');
      expect(e.modalityName, 'Musculação');
      expect(e.isAerobic, isFalse);
      expect(e.defaultSets, 4);
      expect(e.media, hasLength(1));
      expect(e.media.first.kind, ExerciseMediaKind.youtubeUrl);
    });

    test('tolerates the list-item shape (missing detail fields)', () {
      final e = Exercise.fromJson({
        'id': 'ex1',
        'name': 'Agachamento',
        'modalityId': 'm1',
        'modalityName': 'Musculação',
        'primaryMuscleGroupId': 'mg1',
        'isAerobic': true,
      });
      expect(e.name, 'Agachamento');
      expect(e.isAerobic, isTrue);
      expect(e.media, isEmpty);
    });
  });

  test('WorkoutTemplateListItem.fromJson', () {
    final t = WorkoutTemplateListItem.fromJson({
      'id': 't1',
      'name': 'Costas e Ombro',
      'modalityName': 'Musculação',
      'isSystemDefault': true,
      'itemCount': 5,
    });
    expect(t.name, 'Costas e Ombro');
    expect(t.isSystemDefault, isTrue);
    expect(t.itemCount, 5);
  });

  test('Modality.fromJson', () {
    final m = Modality.fromJson({'id': 'm1', 'name': 'Boxe', 'colorHex': '#FF4757', 'isIntervalBased': true});
    expect(m.name, 'Boxe');
    expect(m.isIntervalBased, isTrue);
    expect(m.colorHex, '#FF4757');
  });

  test('SessionNote.fromJson parses metrics and date', () {
    final n = SessionNote.fromJson({
      'id': 'n1',
      'sessionId': 's1',
      'sessionDate': '2026-07-21T12:00:00Z',
      'workoutItemId': 'i1',
      'exerciseId': 'ex1',
      'loadKg': 40.5,
      'painFlag': true,
      'painNote': 'ombro',
      'comment': 'firme',
      'performedSets': 4,
      'performedReps': 10,
    });
    expect(n.exerciseId, 'ex1');
    expect(n.loadKg, 40.5);
    expect(n.painFlag, isTrue);
    expect(n.painNote, 'ombro');
    expect(n.sessionDate.year, 2026);
  });

  group('Profile.fromJson', () {
    test('student profile with blood type + apportments', () {
      final p = Profile.fromJson({
        'isStudent': true,
        'fullName': 'Rita Sibele',
        'email': 'rita@x.com',
        'phone': '1',
        'emergencyPhone': '2',
        'bloodType': 7,
        'heightCm': 165,
        'weightKg': 60.5,
        'photoUrl': 'https://x/p.jpg',
        'apportments': [
          {'id': 'a1', 'bodyPartName': 'Ombro', 'problemTypeName': 'Deslocamento', 'observation': 'ok'},
        ],
      });
      expect(p.isStudent, isTrue);
      expect(p.bloodType, BloodType.oPositive);
      expect(p.bloodType.label, 'O+');
      expect(p.apportments, hasLength(1));
      expect(p.apportments.first.bodyPartName, 'Ombro');
    });

    test('unknown blood type falls back', () {
      final p = Profile.fromJson({'isStudent': false, 'fullName': 'Diego', 'email': 'd@x.com', 'bloodType': 0});
      expect(p.bloodType, BloodType.unknown);
      expect(p.bloodType.label, 'Não informado');
      expect(p.apportments, isEmpty);
    });
  });

  test('WeeklyReport.fromJson', () {
    final r = WeeklyReport.fromJson({
      'weekStart': '2026-07-20',
      'weekEnd': '2026-07-26',
      'sessionCount': 3,
      'completedSessionCount': 2,
      'averageRating': 4.5,
      'distinctWorkoutCount': 2,
      'sessions': [],
      'exercises': [
        {'exerciseId': 'ex1', 'timesPerformed': 2, 'totalSets': 8, 'totalReps': 80, 'maxLoadKg': 45},
      ],
    });
    expect(r.sessionCount, 3);
    expect(r.averageRating, 4.5);
    expect(r.exercises.single.totalReps, 80);
  });

  test('Workout.fromJson groups items', () {
    final w = Workout.fromJson({
      'id': 'w1',
      'ownerStudentId': 'u1',
      'name': 'Treino A',
      'items': [
        {'id': 'i1', 'exerciseId': 'ex1', 'order': 1, 'sets': 4, 'reps': 10, 'restSeconds': 90},
      ],
    });
    expect(w.name, 'Treino A');
    expect(w.items, hasLength(1));
    expect(w.items.first.exerciseId, 'ex1');
  });
}
