// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_push_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotePushInput extends NotePushInput {
  @override
  final String? id;
  @override
  final String? workoutItemId;
  @override
  final String? exerciseId;
  @override
  final num? loadKg;
  @override
  final bool? painFlag;
  @override
  final String? painNote;
  @override
  final String? comment;
  @override
  final int? performedSets;
  @override
  final int? performedReps;
  @override
  final DateTime? createdAt;

  factory _$NotePushInput([void Function(NotePushInputBuilder)? updates]) =>
      (NotePushInputBuilder()..update(updates))._build();

  _$NotePushInput._(
      {this.id,
      this.workoutItemId,
      this.exerciseId,
      this.loadKg,
      this.painFlag,
      this.painNote,
      this.comment,
      this.performedSets,
      this.performedReps,
      this.createdAt})
      : super._();
  @override
  NotePushInput rebuild(void Function(NotePushInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotePushInputBuilder toBuilder() => NotePushInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotePushInput &&
        id == other.id &&
        workoutItemId == other.workoutItemId &&
        exerciseId == other.exerciseId &&
        loadKg == other.loadKg &&
        painFlag == other.painFlag &&
        painNote == other.painNote &&
        comment == other.comment &&
        performedSets == other.performedSets &&
        performedReps == other.performedReps &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, workoutItemId.hashCode);
    _$hash = $jc(_$hash, exerciseId.hashCode);
    _$hash = $jc(_$hash, loadKg.hashCode);
    _$hash = $jc(_$hash, painFlag.hashCode);
    _$hash = $jc(_$hash, painNote.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, performedSets.hashCode);
    _$hash = $jc(_$hash, performedReps.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotePushInput')
          ..add('id', id)
          ..add('workoutItemId', workoutItemId)
          ..add('exerciseId', exerciseId)
          ..add('loadKg', loadKg)
          ..add('painFlag', painFlag)
          ..add('painNote', painNote)
          ..add('comment', comment)
          ..add('performedSets', performedSets)
          ..add('performedReps', performedReps)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class NotePushInputBuilder
    implements Builder<NotePushInput, NotePushInputBuilder> {
  _$NotePushInput? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _workoutItemId;
  String? get workoutItemId => _$this._workoutItemId;
  set workoutItemId(String? workoutItemId) =>
      _$this._workoutItemId = workoutItemId;

  String? _exerciseId;
  String? get exerciseId => _$this._exerciseId;
  set exerciseId(String? exerciseId) => _$this._exerciseId = exerciseId;

  num? _loadKg;
  num? get loadKg => _$this._loadKg;
  set loadKg(num? loadKg) => _$this._loadKg = loadKg;

  bool? _painFlag;
  bool? get painFlag => _$this._painFlag;
  set painFlag(bool? painFlag) => _$this._painFlag = painFlag;

  String? _painNote;
  String? get painNote => _$this._painNote;
  set painNote(String? painNote) => _$this._painNote = painNote;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  int? _performedSets;
  int? get performedSets => _$this._performedSets;
  set performedSets(int? performedSets) =>
      _$this._performedSets = performedSets;

  int? _performedReps;
  int? get performedReps => _$this._performedReps;
  set performedReps(int? performedReps) =>
      _$this._performedReps = performedReps;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  NotePushInputBuilder() {
    NotePushInput._defaults(this);
  }

  NotePushInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _workoutItemId = $v.workoutItemId;
      _exerciseId = $v.exerciseId;
      _loadKg = $v.loadKg;
      _painFlag = $v.painFlag;
      _painNote = $v.painNote;
      _comment = $v.comment;
      _performedSets = $v.performedSets;
      _performedReps = $v.performedReps;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotePushInput other) {
    _$v = other as _$NotePushInput;
  }

  @override
  void update(void Function(NotePushInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotePushInput build() => _build();

  _$NotePushInput _build() {
    final _$result = _$v ??
        _$NotePushInput._(
          id: id,
          workoutItemId: workoutItemId,
          exerciseId: exerciseId,
          loadKg: loadKg,
          painFlag: painFlag,
          painNote: painNote,
          comment: comment,
          performedSets: performedSets,
          performedReps: performedReps,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
