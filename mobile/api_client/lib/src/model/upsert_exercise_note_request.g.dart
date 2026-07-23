// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_exercise_note_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpsertExerciseNoteRequest extends UpsertExerciseNoteRequest {
  @override
  final String workoutItemId;
  @override
  final String exerciseId;
  @override
  final num? loadKg;
  @override
  final bool painFlag;
  @override
  final String? painNote;
  @override
  final String? comment;
  @override
  final int? performedSets;
  @override
  final int? performedReps;

  factory _$UpsertExerciseNoteRequest(
          [void Function(UpsertExerciseNoteRequestBuilder)? updates]) =>
      (UpsertExerciseNoteRequestBuilder()..update(updates))._build();

  _$UpsertExerciseNoteRequest._(
      {required this.workoutItemId,
      required this.exerciseId,
      this.loadKg,
      required this.painFlag,
      this.painNote,
      this.comment,
      this.performedSets,
      this.performedReps})
      : super._();
  @override
  UpsertExerciseNoteRequest rebuild(
          void Function(UpsertExerciseNoteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpsertExerciseNoteRequestBuilder toBuilder() =>
      UpsertExerciseNoteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpsertExerciseNoteRequest &&
        workoutItemId == other.workoutItemId &&
        exerciseId == other.exerciseId &&
        loadKg == other.loadKg &&
        painFlag == other.painFlag &&
        painNote == other.painNote &&
        comment == other.comment &&
        performedSets == other.performedSets &&
        performedReps == other.performedReps;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, workoutItemId.hashCode);
    _$hash = $jc(_$hash, exerciseId.hashCode);
    _$hash = $jc(_$hash, loadKg.hashCode);
    _$hash = $jc(_$hash, painFlag.hashCode);
    _$hash = $jc(_$hash, painNote.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, performedSets.hashCode);
    _$hash = $jc(_$hash, performedReps.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpsertExerciseNoteRequest')
          ..add('workoutItemId', workoutItemId)
          ..add('exerciseId', exerciseId)
          ..add('loadKg', loadKg)
          ..add('painFlag', painFlag)
          ..add('painNote', painNote)
          ..add('comment', comment)
          ..add('performedSets', performedSets)
          ..add('performedReps', performedReps))
        .toString();
  }
}

class UpsertExerciseNoteRequestBuilder
    implements
        Builder<UpsertExerciseNoteRequest, UpsertExerciseNoteRequestBuilder> {
  _$UpsertExerciseNoteRequest? _$v;

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

  UpsertExerciseNoteRequestBuilder() {
    UpsertExerciseNoteRequest._defaults(this);
  }

  UpsertExerciseNoteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _workoutItemId = $v.workoutItemId;
      _exerciseId = $v.exerciseId;
      _loadKg = $v.loadKg;
      _painFlag = $v.painFlag;
      _painNote = $v.painNote;
      _comment = $v.comment;
      _performedSets = $v.performedSets;
      _performedReps = $v.performedReps;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpsertExerciseNoteRequest other) {
    _$v = other as _$UpsertExerciseNoteRequest;
  }

  @override
  void update(void Function(UpsertExerciseNoteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpsertExerciseNoteRequest build() => _build();

  _$UpsertExerciseNoteRequest _build() {
    final _$result = _$v ??
        _$UpsertExerciseNoteRequest._(
          workoutItemId: BuiltValueNullFieldError.checkNotNull(
              workoutItemId, r'UpsertExerciseNoteRequest', 'workoutItemId'),
          exerciseId: BuiltValueNullFieldError.checkNotNull(
              exerciseId, r'UpsertExerciseNoteRequest', 'exerciseId'),
          loadKg: loadKg,
          painFlag: BuiltValueNullFieldError.checkNotNull(
              painFlag, r'UpsertExerciseNoteRequest', 'painFlag'),
          painNote: painNote,
          comment: comment,
          performedSets: performedSets,
          performedReps: performedReps,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
