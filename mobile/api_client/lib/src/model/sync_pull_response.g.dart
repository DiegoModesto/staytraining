// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_pull_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SyncPullResponse extends SyncPullResponse {
  @override
  final DateTime? serverTime;
  @override
  final BuiltList<MuscleGroup>? muscleGroups;
  @override
  final BuiltList<String>? deletedMuscleGroupIds;
  @override
  final BuiltList<Exercise>? exercises;
  @override
  final BuiltList<String>? deletedExerciseIds;
  @override
  final BuiltList<WorkoutTemplate>? templates;
  @override
  final BuiltList<String>? deletedTemplateIds;
  @override
  final BuiltList<Workout>? workouts;
  @override
  final BuiltList<String>? deletedWorkoutIds;
  @override
  final BuiltList<ScheduleSyncItem>? schedules;
  @override
  final BuiltList<String>? deletedScheduleIds;

  factory _$SyncPullResponse(
          [void Function(SyncPullResponseBuilder)? updates]) =>
      (SyncPullResponseBuilder()..update(updates))._build();

  _$SyncPullResponse._(
      {this.serverTime,
      this.muscleGroups,
      this.deletedMuscleGroupIds,
      this.exercises,
      this.deletedExerciseIds,
      this.templates,
      this.deletedTemplateIds,
      this.workouts,
      this.deletedWorkoutIds,
      this.schedules,
      this.deletedScheduleIds})
      : super._();
  @override
  SyncPullResponse rebuild(void Function(SyncPullResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SyncPullResponseBuilder toBuilder() =>
      SyncPullResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SyncPullResponse &&
        serverTime == other.serverTime &&
        muscleGroups == other.muscleGroups &&
        deletedMuscleGroupIds == other.deletedMuscleGroupIds &&
        exercises == other.exercises &&
        deletedExerciseIds == other.deletedExerciseIds &&
        templates == other.templates &&
        deletedTemplateIds == other.deletedTemplateIds &&
        workouts == other.workouts &&
        deletedWorkoutIds == other.deletedWorkoutIds &&
        schedules == other.schedules &&
        deletedScheduleIds == other.deletedScheduleIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, serverTime.hashCode);
    _$hash = $jc(_$hash, muscleGroups.hashCode);
    _$hash = $jc(_$hash, deletedMuscleGroupIds.hashCode);
    _$hash = $jc(_$hash, exercises.hashCode);
    _$hash = $jc(_$hash, deletedExerciseIds.hashCode);
    _$hash = $jc(_$hash, templates.hashCode);
    _$hash = $jc(_$hash, deletedTemplateIds.hashCode);
    _$hash = $jc(_$hash, workouts.hashCode);
    _$hash = $jc(_$hash, deletedWorkoutIds.hashCode);
    _$hash = $jc(_$hash, schedules.hashCode);
    _$hash = $jc(_$hash, deletedScheduleIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SyncPullResponse')
          ..add('serverTime', serverTime)
          ..add('muscleGroups', muscleGroups)
          ..add('deletedMuscleGroupIds', deletedMuscleGroupIds)
          ..add('exercises', exercises)
          ..add('deletedExerciseIds', deletedExerciseIds)
          ..add('templates', templates)
          ..add('deletedTemplateIds', deletedTemplateIds)
          ..add('workouts', workouts)
          ..add('deletedWorkoutIds', deletedWorkoutIds)
          ..add('schedules', schedules)
          ..add('deletedScheduleIds', deletedScheduleIds))
        .toString();
  }
}

class SyncPullResponseBuilder
    implements Builder<SyncPullResponse, SyncPullResponseBuilder> {
  _$SyncPullResponse? _$v;

  DateTime? _serverTime;
  DateTime? get serverTime => _$this._serverTime;
  set serverTime(DateTime? serverTime) => _$this._serverTime = serverTime;

  ListBuilder<MuscleGroup>? _muscleGroups;
  ListBuilder<MuscleGroup> get muscleGroups =>
      _$this._muscleGroups ??= ListBuilder<MuscleGroup>();
  set muscleGroups(ListBuilder<MuscleGroup>? muscleGroups) =>
      _$this._muscleGroups = muscleGroups;

  ListBuilder<String>? _deletedMuscleGroupIds;
  ListBuilder<String> get deletedMuscleGroupIds =>
      _$this._deletedMuscleGroupIds ??= ListBuilder<String>();
  set deletedMuscleGroupIds(ListBuilder<String>? deletedMuscleGroupIds) =>
      _$this._deletedMuscleGroupIds = deletedMuscleGroupIds;

  ListBuilder<Exercise>? _exercises;
  ListBuilder<Exercise> get exercises =>
      _$this._exercises ??= ListBuilder<Exercise>();
  set exercises(ListBuilder<Exercise>? exercises) =>
      _$this._exercises = exercises;

  ListBuilder<String>? _deletedExerciseIds;
  ListBuilder<String> get deletedExerciseIds =>
      _$this._deletedExerciseIds ??= ListBuilder<String>();
  set deletedExerciseIds(ListBuilder<String>? deletedExerciseIds) =>
      _$this._deletedExerciseIds = deletedExerciseIds;

  ListBuilder<WorkoutTemplate>? _templates;
  ListBuilder<WorkoutTemplate> get templates =>
      _$this._templates ??= ListBuilder<WorkoutTemplate>();
  set templates(ListBuilder<WorkoutTemplate>? templates) =>
      _$this._templates = templates;

  ListBuilder<String>? _deletedTemplateIds;
  ListBuilder<String> get deletedTemplateIds =>
      _$this._deletedTemplateIds ??= ListBuilder<String>();
  set deletedTemplateIds(ListBuilder<String>? deletedTemplateIds) =>
      _$this._deletedTemplateIds = deletedTemplateIds;

  ListBuilder<Workout>? _workouts;
  ListBuilder<Workout> get workouts =>
      _$this._workouts ??= ListBuilder<Workout>();
  set workouts(ListBuilder<Workout>? workouts) => _$this._workouts = workouts;

  ListBuilder<String>? _deletedWorkoutIds;
  ListBuilder<String> get deletedWorkoutIds =>
      _$this._deletedWorkoutIds ??= ListBuilder<String>();
  set deletedWorkoutIds(ListBuilder<String>? deletedWorkoutIds) =>
      _$this._deletedWorkoutIds = deletedWorkoutIds;

  ListBuilder<ScheduleSyncItem>? _schedules;
  ListBuilder<ScheduleSyncItem> get schedules =>
      _$this._schedules ??= ListBuilder<ScheduleSyncItem>();
  set schedules(ListBuilder<ScheduleSyncItem>? schedules) =>
      _$this._schedules = schedules;

  ListBuilder<String>? _deletedScheduleIds;
  ListBuilder<String> get deletedScheduleIds =>
      _$this._deletedScheduleIds ??= ListBuilder<String>();
  set deletedScheduleIds(ListBuilder<String>? deletedScheduleIds) =>
      _$this._deletedScheduleIds = deletedScheduleIds;

  SyncPullResponseBuilder() {
    SyncPullResponse._defaults(this);
  }

  SyncPullResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _serverTime = $v.serverTime;
      _muscleGroups = $v.muscleGroups?.toBuilder();
      _deletedMuscleGroupIds = $v.deletedMuscleGroupIds?.toBuilder();
      _exercises = $v.exercises?.toBuilder();
      _deletedExerciseIds = $v.deletedExerciseIds?.toBuilder();
      _templates = $v.templates?.toBuilder();
      _deletedTemplateIds = $v.deletedTemplateIds?.toBuilder();
      _workouts = $v.workouts?.toBuilder();
      _deletedWorkoutIds = $v.deletedWorkoutIds?.toBuilder();
      _schedules = $v.schedules?.toBuilder();
      _deletedScheduleIds = $v.deletedScheduleIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SyncPullResponse other) {
    _$v = other as _$SyncPullResponse;
  }

  @override
  void update(void Function(SyncPullResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SyncPullResponse build() => _build();

  _$SyncPullResponse _build() {
    _$SyncPullResponse _$result;
    try {
      _$result = _$v ??
          _$SyncPullResponse._(
            serverTime: serverTime,
            muscleGroups: _muscleGroups?.build(),
            deletedMuscleGroupIds: _deletedMuscleGroupIds?.build(),
            exercises: _exercises?.build(),
            deletedExerciseIds: _deletedExerciseIds?.build(),
            templates: _templates?.build(),
            deletedTemplateIds: _deletedTemplateIds?.build(),
            workouts: _workouts?.build(),
            deletedWorkoutIds: _deletedWorkoutIds?.build(),
            schedules: _schedules?.build(),
            deletedScheduleIds: _deletedScheduleIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'muscleGroups';
        _muscleGroups?.build();
        _$failedField = 'deletedMuscleGroupIds';
        _deletedMuscleGroupIds?.build();
        _$failedField = 'exercises';
        _exercises?.build();
        _$failedField = 'deletedExerciseIds';
        _deletedExerciseIds?.build();
        _$failedField = 'templates';
        _templates?.build();
        _$failedField = 'deletedTemplateIds';
        _deletedTemplateIds?.build();
        _$failedField = 'workouts';
        _workouts?.build();
        _$failedField = 'deletedWorkoutIds';
        _deletedWorkoutIds?.build();
        _$failedField = 'schedules';
        _schedules?.build();
        _$failedField = 'deletedScheduleIds';
        _deletedScheduleIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SyncPullResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
