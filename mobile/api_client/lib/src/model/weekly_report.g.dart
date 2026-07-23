// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_report.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WeeklyReport extends WeeklyReport {
  @override
  final Date? weekStart;
  @override
  final Date? weekEnd;
  @override
  final int? sessionCount;
  @override
  final int? completedSessionCount;
  @override
  final num? averageRating;
  @override
  final int? distinctWorkoutCount;
  @override
  final BuiltList<WeeklyReportSession>? sessions;
  @override
  final BuiltList<WeeklyReportExercise>? exercises;

  factory _$WeeklyReport([void Function(WeeklyReportBuilder)? updates]) =>
      (WeeklyReportBuilder()..update(updates))._build();

  _$WeeklyReport._(
      {this.weekStart,
      this.weekEnd,
      this.sessionCount,
      this.completedSessionCount,
      this.averageRating,
      this.distinctWorkoutCount,
      this.sessions,
      this.exercises})
      : super._();
  @override
  WeeklyReport rebuild(void Function(WeeklyReportBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeeklyReportBuilder toBuilder() => WeeklyReportBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeeklyReport &&
        weekStart == other.weekStart &&
        weekEnd == other.weekEnd &&
        sessionCount == other.sessionCount &&
        completedSessionCount == other.completedSessionCount &&
        averageRating == other.averageRating &&
        distinctWorkoutCount == other.distinctWorkoutCount &&
        sessions == other.sessions &&
        exercises == other.exercises;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, weekStart.hashCode);
    _$hash = $jc(_$hash, weekEnd.hashCode);
    _$hash = $jc(_$hash, sessionCount.hashCode);
    _$hash = $jc(_$hash, completedSessionCount.hashCode);
    _$hash = $jc(_$hash, averageRating.hashCode);
    _$hash = $jc(_$hash, distinctWorkoutCount.hashCode);
    _$hash = $jc(_$hash, sessions.hashCode);
    _$hash = $jc(_$hash, exercises.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeeklyReport')
          ..add('weekStart', weekStart)
          ..add('weekEnd', weekEnd)
          ..add('sessionCount', sessionCount)
          ..add('completedSessionCount', completedSessionCount)
          ..add('averageRating', averageRating)
          ..add('distinctWorkoutCount', distinctWorkoutCount)
          ..add('sessions', sessions)
          ..add('exercises', exercises))
        .toString();
  }
}

class WeeklyReportBuilder
    implements Builder<WeeklyReport, WeeklyReportBuilder> {
  _$WeeklyReport? _$v;

  Date? _weekStart;
  Date? get weekStart => _$this._weekStart;
  set weekStart(Date? weekStart) => _$this._weekStart = weekStart;

  Date? _weekEnd;
  Date? get weekEnd => _$this._weekEnd;
  set weekEnd(Date? weekEnd) => _$this._weekEnd = weekEnd;

  int? _sessionCount;
  int? get sessionCount => _$this._sessionCount;
  set sessionCount(int? sessionCount) => _$this._sessionCount = sessionCount;

  int? _completedSessionCount;
  int? get completedSessionCount => _$this._completedSessionCount;
  set completedSessionCount(int? completedSessionCount) =>
      _$this._completedSessionCount = completedSessionCount;

  num? _averageRating;
  num? get averageRating => _$this._averageRating;
  set averageRating(num? averageRating) =>
      _$this._averageRating = averageRating;

  int? _distinctWorkoutCount;
  int? get distinctWorkoutCount => _$this._distinctWorkoutCount;
  set distinctWorkoutCount(int? distinctWorkoutCount) =>
      _$this._distinctWorkoutCount = distinctWorkoutCount;

  ListBuilder<WeeklyReportSession>? _sessions;
  ListBuilder<WeeklyReportSession> get sessions =>
      _$this._sessions ??= ListBuilder<WeeklyReportSession>();
  set sessions(ListBuilder<WeeklyReportSession>? sessions) =>
      _$this._sessions = sessions;

  ListBuilder<WeeklyReportExercise>? _exercises;
  ListBuilder<WeeklyReportExercise> get exercises =>
      _$this._exercises ??= ListBuilder<WeeklyReportExercise>();
  set exercises(ListBuilder<WeeklyReportExercise>? exercises) =>
      _$this._exercises = exercises;

  WeeklyReportBuilder() {
    WeeklyReport._defaults(this);
  }

  WeeklyReportBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _weekStart = $v.weekStart;
      _weekEnd = $v.weekEnd;
      _sessionCount = $v.sessionCount;
      _completedSessionCount = $v.completedSessionCount;
      _averageRating = $v.averageRating;
      _distinctWorkoutCount = $v.distinctWorkoutCount;
      _sessions = $v.sessions?.toBuilder();
      _exercises = $v.exercises?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeeklyReport other) {
    _$v = other as _$WeeklyReport;
  }

  @override
  void update(void Function(WeeklyReportBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeeklyReport build() => _build();

  _$WeeklyReport _build() {
    _$WeeklyReport _$result;
    try {
      _$result = _$v ??
          _$WeeklyReport._(
            weekStart: weekStart,
            weekEnd: weekEnd,
            sessionCount: sessionCount,
            completedSessionCount: completedSessionCount,
            averageRating: averageRating,
            distinctWorkoutCount: distinctWorkoutCount,
            sessions: _sessions?.build(),
            exercises: _exercises?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sessions';
        _sessions?.build();
        _$failedField = 'exercises';
        _exercises?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'WeeklyReport', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
