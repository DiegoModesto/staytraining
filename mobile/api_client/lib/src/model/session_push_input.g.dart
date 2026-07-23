// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_push_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SessionPushInput extends SessionPushInput {
  @override
  final String? id;
  @override
  final String? workoutId;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final int? completionRating;
  @override
  final String? overallComment;
  @override
  final BuiltList<NotePushInput>? notes;

  factory _$SessionPushInput(
          [void Function(SessionPushInputBuilder)? updates]) =>
      (SessionPushInputBuilder()..update(updates))._build();

  _$SessionPushInput._(
      {this.id,
      this.workoutId,
      this.startedAt,
      this.completedAt,
      this.completionRating,
      this.overallComment,
      this.notes})
      : super._();
  @override
  SessionPushInput rebuild(void Function(SessionPushInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionPushInputBuilder toBuilder() =>
      SessionPushInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionPushInput &&
        id == other.id &&
        workoutId == other.workoutId &&
        startedAt == other.startedAt &&
        completedAt == other.completedAt &&
        completionRating == other.completionRating &&
        overallComment == other.overallComment &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, workoutId.hashCode);
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jc(_$hash, completionRating.hashCode);
    _$hash = $jc(_$hash, overallComment.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SessionPushInput')
          ..add('id', id)
          ..add('workoutId', workoutId)
          ..add('startedAt', startedAt)
          ..add('completedAt', completedAt)
          ..add('completionRating', completionRating)
          ..add('overallComment', overallComment)
          ..add('notes', notes))
        .toString();
  }
}

class SessionPushInputBuilder
    implements Builder<SessionPushInput, SessionPushInputBuilder> {
  _$SessionPushInput? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _workoutId;
  String? get workoutId => _$this._workoutId;
  set workoutId(String? workoutId) => _$this._workoutId = workoutId;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  int? _completionRating;
  int? get completionRating => _$this._completionRating;
  set completionRating(int? completionRating) =>
      _$this._completionRating = completionRating;

  String? _overallComment;
  String? get overallComment => _$this._overallComment;
  set overallComment(String? overallComment) =>
      _$this._overallComment = overallComment;

  ListBuilder<NotePushInput>? _notes;
  ListBuilder<NotePushInput> get notes =>
      _$this._notes ??= ListBuilder<NotePushInput>();
  set notes(ListBuilder<NotePushInput>? notes) => _$this._notes = notes;

  SessionPushInputBuilder() {
    SessionPushInput._defaults(this);
  }

  SessionPushInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _workoutId = $v.workoutId;
      _startedAt = $v.startedAt;
      _completedAt = $v.completedAt;
      _completionRating = $v.completionRating;
      _overallComment = $v.overallComment;
      _notes = $v.notes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionPushInput other) {
    _$v = other as _$SessionPushInput;
  }

  @override
  void update(void Function(SessionPushInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionPushInput build() => _build();

  _$SessionPushInput _build() {
    _$SessionPushInput _$result;
    try {
      _$result = _$v ??
          _$SessionPushInput._(
            id: id,
            workoutId: workoutId,
            startedAt: startedAt,
            completedAt: completedAt,
            completionRating: completionRating,
            overallComment: overallComment,
            notes: _notes?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'notes';
        _notes?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SessionPushInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
