// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_report_session.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WeeklyReportSession extends WeeklyReportSession {
  @override
  final String? sessionId;
  @override
  final String? workoutId;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final int? rating;
  @override
  final int? noteCount;

  factory _$WeeklyReportSession(
          [void Function(WeeklyReportSessionBuilder)? updates]) =>
      (WeeklyReportSessionBuilder()..update(updates))._build();

  _$WeeklyReportSession._(
      {this.sessionId,
      this.workoutId,
      this.startedAt,
      this.completedAt,
      this.rating,
      this.noteCount})
      : super._();
  @override
  WeeklyReportSession rebuild(
          void Function(WeeklyReportSessionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeeklyReportSessionBuilder toBuilder() =>
      WeeklyReportSessionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeeklyReportSession &&
        sessionId == other.sessionId &&
        workoutId == other.workoutId &&
        startedAt == other.startedAt &&
        completedAt == other.completedAt &&
        rating == other.rating &&
        noteCount == other.noteCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, workoutId.hashCode);
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, noteCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeeklyReportSession')
          ..add('sessionId', sessionId)
          ..add('workoutId', workoutId)
          ..add('startedAt', startedAt)
          ..add('completedAt', completedAt)
          ..add('rating', rating)
          ..add('noteCount', noteCount))
        .toString();
  }
}

class WeeklyReportSessionBuilder
    implements Builder<WeeklyReportSession, WeeklyReportSessionBuilder> {
  _$WeeklyReportSession? _$v;

  String? _sessionId;
  String? get sessionId => _$this._sessionId;
  set sessionId(String? sessionId) => _$this._sessionId = sessionId;

  String? _workoutId;
  String? get workoutId => _$this._workoutId;
  set workoutId(String? workoutId) => _$this._workoutId = workoutId;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  int? _noteCount;
  int? get noteCount => _$this._noteCount;
  set noteCount(int? noteCount) => _$this._noteCount = noteCount;

  WeeklyReportSessionBuilder() {
    WeeklyReportSession._defaults(this);
  }

  WeeklyReportSessionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _workoutId = $v.workoutId;
      _startedAt = $v.startedAt;
      _completedAt = $v.completedAt;
      _rating = $v.rating;
      _noteCount = $v.noteCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeeklyReportSession other) {
    _$v = other as _$WeeklyReportSession;
  }

  @override
  void update(void Function(WeeklyReportSessionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeeklyReportSession build() => _build();

  _$WeeklyReportSession _build() {
    final _$result = _$v ??
        _$WeeklyReportSession._(
          sessionId: sessionId,
          workoutId: workoutId,
          startedAt: startedAt,
          completedAt: completedAt,
          rating: rating,
          noteCount: noteCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
