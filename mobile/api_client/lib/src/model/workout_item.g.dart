// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class WorkoutItemBuilder {
  void replace(WorkoutItem other);
  void update(void Function(WorkoutItemBuilder) updates);
  String? get id;
  set id(String? id);

  String? get exerciseId;
  set exerciseId(String? exerciseId);

  int? get order;
  set order(int? order);

  String? get sectionLabel;
  set sectionLabel(String? sectionLabel);

  int? get sets;
  set sets(int? sets);

  int? get reps;
  set reps(int? reps);

  int? get restSeconds;
  set restSeconds(int? restSeconds);

  int? get durationSeconds;
  set durationSeconds(int? durationSeconds);

  int? get workSeconds;
  set workSeconds(int? workSeconds);

  int? get intervalRestSeconds;
  set intervalRestSeconds(int? intervalRestSeconds);

  int? get rounds;
  set rounds(int? rounds);

  String? get professorComment;
  set professorComment(String? professorComment);
}

class _$$WorkoutItem extends $WorkoutItem {
  @override
  final String? id;
  @override
  final String? exerciseId;
  @override
  final int? order;
  @override
  final String? sectionLabel;
  @override
  final int? sets;
  @override
  final int? reps;
  @override
  final int? restSeconds;
  @override
  final int? durationSeconds;
  @override
  final int? workSeconds;
  @override
  final int? intervalRestSeconds;
  @override
  final int? rounds;
  @override
  final String? professorComment;

  factory _$$WorkoutItem([void Function($WorkoutItemBuilder)? updates]) =>
      ($WorkoutItemBuilder()..update(updates))._build();

  _$$WorkoutItem._(
      {this.id,
      this.exerciseId,
      this.order,
      this.sectionLabel,
      this.sets,
      this.reps,
      this.restSeconds,
      this.durationSeconds,
      this.workSeconds,
      this.intervalRestSeconds,
      this.rounds,
      this.professorComment})
      : super._();
  @override
  $WorkoutItem rebuild(void Function($WorkoutItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $WorkoutItemBuilder toBuilder() => $WorkoutItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $WorkoutItem &&
        id == other.id &&
        exerciseId == other.exerciseId &&
        order == other.order &&
        sectionLabel == other.sectionLabel &&
        sets == other.sets &&
        reps == other.reps &&
        restSeconds == other.restSeconds &&
        durationSeconds == other.durationSeconds &&
        workSeconds == other.workSeconds &&
        intervalRestSeconds == other.intervalRestSeconds &&
        rounds == other.rounds &&
        professorComment == other.professorComment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, exerciseId.hashCode);
    _$hash = $jc(_$hash, order.hashCode);
    _$hash = $jc(_$hash, sectionLabel.hashCode);
    _$hash = $jc(_$hash, sets.hashCode);
    _$hash = $jc(_$hash, reps.hashCode);
    _$hash = $jc(_$hash, restSeconds.hashCode);
    _$hash = $jc(_$hash, durationSeconds.hashCode);
    _$hash = $jc(_$hash, workSeconds.hashCode);
    _$hash = $jc(_$hash, intervalRestSeconds.hashCode);
    _$hash = $jc(_$hash, rounds.hashCode);
    _$hash = $jc(_$hash, professorComment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$WorkoutItem')
          ..add('id', id)
          ..add('exerciseId', exerciseId)
          ..add('order', order)
          ..add('sectionLabel', sectionLabel)
          ..add('sets', sets)
          ..add('reps', reps)
          ..add('restSeconds', restSeconds)
          ..add('durationSeconds', durationSeconds)
          ..add('workSeconds', workSeconds)
          ..add('intervalRestSeconds', intervalRestSeconds)
          ..add('rounds', rounds)
          ..add('professorComment', professorComment))
        .toString();
  }
}

class $WorkoutItemBuilder
    implements Builder<$WorkoutItem, $WorkoutItemBuilder>, WorkoutItemBuilder {
  _$$WorkoutItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _exerciseId;
  String? get exerciseId => _$this._exerciseId;
  set exerciseId(covariant String? exerciseId) =>
      _$this._exerciseId = exerciseId;

  int? _order;
  int? get order => _$this._order;
  set order(covariant int? order) => _$this._order = order;

  String? _sectionLabel;
  String? get sectionLabel => _$this._sectionLabel;
  set sectionLabel(covariant String? sectionLabel) =>
      _$this._sectionLabel = sectionLabel;

  int? _sets;
  int? get sets => _$this._sets;
  set sets(covariant int? sets) => _$this._sets = sets;

  int? _reps;
  int? get reps => _$this._reps;
  set reps(covariant int? reps) => _$this._reps = reps;

  int? _restSeconds;
  int? get restSeconds => _$this._restSeconds;
  set restSeconds(covariant int? restSeconds) =>
      _$this._restSeconds = restSeconds;

  int? _durationSeconds;
  int? get durationSeconds => _$this._durationSeconds;
  set durationSeconds(covariant int? durationSeconds) =>
      _$this._durationSeconds = durationSeconds;

  int? _workSeconds;
  int? get workSeconds => _$this._workSeconds;
  set workSeconds(covariant int? workSeconds) =>
      _$this._workSeconds = workSeconds;

  int? _intervalRestSeconds;
  int? get intervalRestSeconds => _$this._intervalRestSeconds;
  set intervalRestSeconds(covariant int? intervalRestSeconds) =>
      _$this._intervalRestSeconds = intervalRestSeconds;

  int? _rounds;
  int? get rounds => _$this._rounds;
  set rounds(covariant int? rounds) => _$this._rounds = rounds;

  String? _professorComment;
  String? get professorComment => _$this._professorComment;
  set professorComment(covariant String? professorComment) =>
      _$this._professorComment = professorComment;

  $WorkoutItemBuilder() {
    $WorkoutItem._defaults(this);
  }

  $WorkoutItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _exerciseId = $v.exerciseId;
      _order = $v.order;
      _sectionLabel = $v.sectionLabel;
      _sets = $v.sets;
      _reps = $v.reps;
      _restSeconds = $v.restSeconds;
      _durationSeconds = $v.durationSeconds;
      _workSeconds = $v.workSeconds;
      _intervalRestSeconds = $v.intervalRestSeconds;
      _rounds = $v.rounds;
      _professorComment = $v.professorComment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $WorkoutItem other) {
    _$v = other as _$$WorkoutItem;
  }

  @override
  void update(void Function($WorkoutItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $WorkoutItem build() => _build();

  _$$WorkoutItem _build() {
    final _$result = _$v ??
        _$$WorkoutItem._(
          id: id,
          exerciseId: exerciseId,
          order: order,
          sectionLabel: sectionLabel,
          sets: sets,
          reps: reps,
          restSeconds: restSeconds,
          durationSeconds: durationSeconds,
          workSeconds: workSeconds,
          intervalRestSeconds: intervalRestSeconds,
          rounds: rounds,
          professorComment: professorComment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
