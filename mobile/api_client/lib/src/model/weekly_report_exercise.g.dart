// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_report_exercise.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WeeklyReportExercise extends WeeklyReportExercise {
  @override
  final String? exerciseId;
  @override
  final int? timesPerformed;
  @override
  final int? totalSets;
  @override
  final int? totalReps;
  @override
  final num? maxLoadKg;

  factory _$WeeklyReportExercise(
          [void Function(WeeklyReportExerciseBuilder)? updates]) =>
      (WeeklyReportExerciseBuilder()..update(updates))._build();

  _$WeeklyReportExercise._(
      {this.exerciseId,
      this.timesPerformed,
      this.totalSets,
      this.totalReps,
      this.maxLoadKg})
      : super._();
  @override
  WeeklyReportExercise rebuild(
          void Function(WeeklyReportExerciseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeeklyReportExerciseBuilder toBuilder() =>
      WeeklyReportExerciseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeeklyReportExercise &&
        exerciseId == other.exerciseId &&
        timesPerformed == other.timesPerformed &&
        totalSets == other.totalSets &&
        totalReps == other.totalReps &&
        maxLoadKg == other.maxLoadKg;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, exerciseId.hashCode);
    _$hash = $jc(_$hash, timesPerformed.hashCode);
    _$hash = $jc(_$hash, totalSets.hashCode);
    _$hash = $jc(_$hash, totalReps.hashCode);
    _$hash = $jc(_$hash, maxLoadKg.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeeklyReportExercise')
          ..add('exerciseId', exerciseId)
          ..add('timesPerformed', timesPerformed)
          ..add('totalSets', totalSets)
          ..add('totalReps', totalReps)
          ..add('maxLoadKg', maxLoadKg))
        .toString();
  }
}

class WeeklyReportExerciseBuilder
    implements Builder<WeeklyReportExercise, WeeklyReportExerciseBuilder> {
  _$WeeklyReportExercise? _$v;

  String? _exerciseId;
  String? get exerciseId => _$this._exerciseId;
  set exerciseId(String? exerciseId) => _$this._exerciseId = exerciseId;

  int? _timesPerformed;
  int? get timesPerformed => _$this._timesPerformed;
  set timesPerformed(int? timesPerformed) =>
      _$this._timesPerformed = timesPerformed;

  int? _totalSets;
  int? get totalSets => _$this._totalSets;
  set totalSets(int? totalSets) => _$this._totalSets = totalSets;

  int? _totalReps;
  int? get totalReps => _$this._totalReps;
  set totalReps(int? totalReps) => _$this._totalReps = totalReps;

  num? _maxLoadKg;
  num? get maxLoadKg => _$this._maxLoadKg;
  set maxLoadKg(num? maxLoadKg) => _$this._maxLoadKg = maxLoadKg;

  WeeklyReportExerciseBuilder() {
    WeeklyReportExercise._defaults(this);
  }

  WeeklyReportExerciseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _exerciseId = $v.exerciseId;
      _timesPerformed = $v.timesPerformed;
      _totalSets = $v.totalSets;
      _totalReps = $v.totalReps;
      _maxLoadKg = $v.maxLoadKg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeeklyReportExercise other) {
    _$v = other as _$WeeklyReportExercise;
  }

  @override
  void update(void Function(WeeklyReportExerciseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeeklyReportExercise build() => _build();

  _$WeeklyReportExercise _build() {
    final _$result = _$v ??
        _$WeeklyReportExercise._(
          exerciseId: exerciseId,
          timesPerformed: timesPerformed,
          totalSets: totalSets,
          totalReps: totalReps,
          maxLoadKg: maxLoadKg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
