// Data models mirroring the StayTraining Web.API responses.
// Enums map to the API's numeric enum values (index-based).
//
// "Modalidade" used to be a fixed enum; it is now an admin-managed catalog. Responses carry the
// modality id plus a denormalized modality name (label), so this app just shows the name.

enum ExerciseMediaKind { gif, uploadedVideo, youtubeUrl, muscleImage }

class MuscleGroup {
  MuscleGroup({required this.id, required this.name, required this.bodyRegion});
  final String id;
  final String name;
  final String bodyRegion;

  factory MuscleGroup.fromJson(Map<String, dynamic> j) => MuscleGroup(
        id: j['id'] as String,
        name: j['name'] as String,
        bodyRegion: (j['bodyRegion'] ?? '') as String,
      );
}

class ExerciseMedia {
  ExerciseMedia({required this.id, required this.kind, this.storageKey, this.url});
  final String id;
  final ExerciseMediaKind kind;
  final String? storageKey;
  final String? url;

  factory ExerciseMedia.fromJson(Map<String, dynamic> j) => ExerciseMedia(
        id: j['id'] as String,
        kind: ExerciseMediaKind.values[(j['kind'] as int?) ?? 0],
        storageKey: j['storageKey'] as String?,
        url: j['url'] as String?,
      );
}

class Exercise {
  Exercise({
    required this.id,
    required this.name,
    this.description,
    required this.modalityId,
    required this.modalityName,
    required this.primaryMuscleGroupId,
    this.usageExample,
    required this.defaultSets,
    required this.defaultReps,
    required this.defaultRestSeconds,
    required this.isAerobic,
    this.defaultWorkSeconds,
    this.defaultIntervalRestSeconds,
    this.defaultRounds,
    this.media = const [],
  });

  final String id;
  final String name;
  final String? description;
  final String modalityId;
  final String modalityName;
  final String primaryMuscleGroupId;
  final String? usageExample;
  final int defaultSets;
  final int defaultReps;
  final int defaultRestSeconds;
  final bool isAerobic;
  final int? defaultWorkSeconds;
  final int? defaultIntervalRestSeconds;
  final int? defaultRounds;
  final List<ExerciseMedia> media;

  factory Exercise.fromJson(Map<String, dynamic> j) => Exercise(
        id: j['id'] as String,
        name: j['name'] as String,
        description: j['description'] as String?,
        modalityId: (j['modalityId'] ?? '') as String,
        modalityName: (j['modalityName'] ?? '') as String,
        primaryMuscleGroupId: (j['primaryMuscleGroupId'] ?? '') as String,
        usageExample: j['usageExample'] as String?,
        defaultSets: (j['defaultSets'] as int?) ?? 0,
        defaultReps: (j['defaultReps'] as int?) ?? 0,
        defaultRestSeconds: (j['defaultRestSeconds'] as int?) ?? 0,
        isAerobic: (j['isAerobic'] as bool?) ?? false,
        defaultWorkSeconds: j['defaultWorkSeconds'] as int?,
        defaultIntervalRestSeconds: j['defaultIntervalRestSeconds'] as int?,
        defaultRounds: j['defaultRounds'] as int?,
        media: ((j['media'] as List?) ?? [])
            .map((m) => ExerciseMedia.fromJson(m as Map<String, dynamic>))
            .toList(),
      );
}

class WorkoutItem {
  WorkoutItem({
    required this.id,
    required this.exerciseId,
    required this.order,
    this.sectionLabel,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    this.durationSeconds,
    this.workSeconds,
    this.intervalRestSeconds,
    this.rounds,
    this.professorComment,
  });

  final String id;
  final String exerciseId;
  final int order;
  final String? sectionLabel;
  final int sets;
  final int reps;
  final int restSeconds;
  final int? durationSeconds;
  final int? workSeconds;
  final int? intervalRestSeconds;
  final int? rounds;
  final String? professorComment;

  bool get isInterval => workSeconds != null && (rounds ?? 0) > 0;

  factory WorkoutItem.fromJson(Map<String, dynamic> j) => WorkoutItem(
        id: j['id'] as String,
        exerciseId: j['exerciseId'] as String,
        order: (j['order'] as int?) ?? 0,
        sectionLabel: j['sectionLabel'] as String?,
        sets: (j['sets'] as int?) ?? 0,
        reps: (j['reps'] as int?) ?? 0,
        restSeconds: (j['restSeconds'] as int?) ?? 0,
        durationSeconds: j['durationSeconds'] as int?,
        workSeconds: j['workSeconds'] as int?,
        intervalRestSeconds: j['intervalRestSeconds'] as int?,
        rounds: j['rounds'] as int?,
        professorComment: j['professorComment'] as String?,
      );
}

class Workout {
  Workout({
    required this.id,
    required this.ownerStudentId,
    this.sourceTemplateId,
    required this.name,
    this.description,
    this.modalityId,
    this.modalityName,
    this.items = const [],
  });

  final String id;
  final String ownerStudentId;
  final String? sourceTemplateId;
  final String name;
  final String? description;
  final String? modalityId;
  final String? modalityName;
  final List<WorkoutItem> items;

  factory Workout.fromJson(Map<String, dynamic> j) => Workout(
        id: j['id'] as String,
        ownerStudentId: (j['ownerStudentId'] ?? '') as String,
        sourceTemplateId: j['sourceTemplateId'] as String?,
        name: j['name'] as String,
        description: j['description'] as String?,
        modalityId: j['modalityId'] as String?,
        modalityName: j['modalityName'] as String?,
        items: ((j['items'] as List?) ?? [])
            .map((i) => WorkoutItem.fromJson(i as Map<String, dynamic>))
            .toList(),
      );
}

class WorkoutListItem {
  WorkoutListItem({required this.id, required this.name, this.modalityId, this.modalityName, required this.itemCount});
  final String id;
  final String name;
  final String? modalityId;
  final String? modalityName;
  final int itemCount;

  factory WorkoutListItem.fromJson(Map<String, dynamic> j) => WorkoutListItem(
        id: j['id'] as String,
        name: j['name'] as String,
        modalityId: j['modalityId'] as String?,
        modalityName: j['modalityName'] as String?,
        itemCount: (j['itemCount'] as int?) ?? 0,
      );
}

class WeekScheduleItem {
  WeekScheduleItem({required this.scheduleId, required this.date, required this.workoutId, required this.workoutName});
  final String scheduleId;
  final DateTime date;
  final String workoutId;
  final String workoutName;

  factory WeekScheduleItem.fromJson(Map<String, dynamic> j) => WeekScheduleItem(
        scheduleId: j['scheduleId'] as String,
        date: DateTime.parse(j['date'] as String),
        workoutId: j['workoutId'] as String,
        workoutName: j['workoutName'] as String,
      );
}

class WeeklyReport {
  WeeklyReport({
    required this.sessionCount,
    required this.completedSessionCount,
    this.averageRating,
    required this.distinctWorkoutCount,
    required this.exercises,
  });

  final int sessionCount;
  final int completedSessionCount;
  final double? averageRating;
  final int distinctWorkoutCount;
  final List<WeeklyReportExercise> exercises;

  factory WeeklyReport.fromJson(Map<String, dynamic> j) => WeeklyReport(
        sessionCount: (j['sessionCount'] as int?) ?? 0,
        completedSessionCount: (j['completedSessionCount'] as int?) ?? 0,
        averageRating: (j['averageRating'] as num?)?.toDouble(),
        distinctWorkoutCount: (j['distinctWorkoutCount'] as int?) ?? 0,
        exercises: ((j['exercises'] as List?) ?? [])
            .map((e) => WeeklyReportExercise.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class WeeklyReportExercise {
  WeeklyReportExercise({
    required this.exerciseId,
    required this.timesPerformed,
    required this.totalSets,
    required this.totalReps,
    this.maxLoadKg,
  });
  final String exerciseId;
  final int timesPerformed;
  final int totalSets;
  final int totalReps;
  final double? maxLoadKg;

  factory WeeklyReportExercise.fromJson(Map<String, dynamic> j) => WeeklyReportExercise(
        exerciseId: j['exerciseId'] as String,
        timesPerformed: (j['timesPerformed'] as int?) ?? 0,
        totalSets: (j['totalSets'] as int?) ?? 0,
        totalReps: (j['totalReps'] as int?) ?? 0,
        maxLoadKg: (j['maxLoadKg'] as num?)?.toDouble(),
      );
}

// ----- Profile / ficha -----

// Mirrors Domain.Profiles.BloodType (numeric JSON).
enum BloodType { unknown, aPositive, aNegative, bPositive, bNegative, abPositive, abNegative, oPositive, oNegative }

BloodType bloodTypeFromInt(int v) =>
    BloodType.values[(v >= 0 && v < BloodType.values.length) ? v : 0];

extension BloodTypeLabel on BloodType {
  String get label => switch (this) {
        BloodType.aPositive => 'A+',
        BloodType.aNegative => 'A−',
        BloodType.bPositive => 'B+',
        BloodType.bNegative => 'B−',
        BloodType.abPositive => 'AB+',
        BloodType.abNegative => 'AB−',
        BloodType.oPositive => 'O+',
        BloodType.oNegative => 'O−',
        _ => 'Não informado',
      };
}

class ProfileApportment {
  ProfileApportment({required this.id, required this.bodyPartName, required this.problemTypeName, this.observation});
  final String id;
  final String bodyPartName;
  final String problemTypeName;
  final String? observation;

  factory ProfileApportment.fromJson(Map<String, dynamic> j) => ProfileApportment(
        id: j['id'] as String,
        bodyPartName: (j['bodyPartName'] ?? '') as String,
        problemTypeName: (j['problemTypeName'] ?? '') as String,
        observation: j['observation'] as String?,
      );
}

class Profile {
  Profile({
    required this.isStudent,
    required this.fullName,
    required this.email,
    this.phone,
    this.emergencyPhone,
    this.bloodType = BloodType.unknown,
    this.heightCm,
    this.weightKg,
    this.photoUrl,
    this.apportments = const [],
  });

  final bool isStudent;
  final String fullName;
  final String email;
  final String? phone;
  final String? emergencyPhone;
  final BloodType bloodType;
  final int? heightCm;
  final double? weightKg;
  final String? photoUrl;
  final List<ProfileApportment> apportments;

  factory Profile.fromJson(Map<String, dynamic> j) => Profile(
        isStudent: (j['isStudent'] as bool?) ?? false,
        fullName: (j['fullName'] ?? '') as String,
        email: (j['email'] ?? '') as String,
        phone: j['phone'] as String?,
        emergencyPhone: j['emergencyPhone'] as String?,
        bloodType: bloodTypeFromInt((j['bloodType'] as int?) ?? 0),
        heightCm: j['heightCm'] as int?,
        weightKg: (j['weightKg'] as num?)?.toDouble(),
        photoUrl: j['photoUrl'] as String?,
        apportments: ((j['apportments'] as List?) ?? [])
            .map((a) => ProfileApportment.fromJson(a as Map<String, dynamic>))
            .toList(),
      );
}

class CatalogProblemType {
  CatalogProblemType({required this.id, required this.name});
  final String id;
  final String name;

  factory CatalogProblemType.fromJson(Map<String, dynamic> j) =>
      CatalogProblemType(id: j['id'] as String, name: (j['name'] ?? '') as String);
}

class CatalogBodyPart {
  CatalogBodyPart({required this.id, required this.name, this.problemTypes = const []});
  final String id;
  final String name;
  final List<CatalogProblemType> problemTypes;

  factory CatalogBodyPart.fromJson(Map<String, dynamic> j) => CatalogBodyPart(
        id: j['id'] as String,
        name: (j['name'] ?? '') as String,
        problemTypes: ((j['problemTypes'] as List?) ?? [])
            .map((p) => CatalogProblemType.fromJson(p as Map<String, dynamic>))
            .toList(),
      );
}
