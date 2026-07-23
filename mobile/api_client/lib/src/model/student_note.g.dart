// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_note.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentNote extends StudentNote {
  @override
  final String? id;
  @override
  final String? workoutId;
  @override
  final String? authorUserId;
  @override
  final String? authorName;
  @override
  final String? content;
  @override
  final DateTime? createdAt;

  factory _$StudentNote([void Function(StudentNoteBuilder)? updates]) =>
      (StudentNoteBuilder()..update(updates))._build();

  _$StudentNote._(
      {this.id,
      this.workoutId,
      this.authorUserId,
      this.authorName,
      this.content,
      this.createdAt})
      : super._();
  @override
  StudentNote rebuild(void Function(StudentNoteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StudentNoteBuilder toBuilder() => StudentNoteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentNote &&
        id == other.id &&
        workoutId == other.workoutId &&
        authorUserId == other.authorUserId &&
        authorName == other.authorName &&
        content == other.content &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, workoutId.hashCode);
    _$hash = $jc(_$hash, authorUserId.hashCode);
    _$hash = $jc(_$hash, authorName.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentNote')
          ..add('id', id)
          ..add('workoutId', workoutId)
          ..add('authorUserId', authorUserId)
          ..add('authorName', authorName)
          ..add('content', content)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class StudentNoteBuilder implements Builder<StudentNote, StudentNoteBuilder> {
  _$StudentNote? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _workoutId;
  String? get workoutId => _$this._workoutId;
  set workoutId(String? workoutId) => _$this._workoutId = workoutId;

  String? _authorUserId;
  String? get authorUserId => _$this._authorUserId;
  set authorUserId(String? authorUserId) => _$this._authorUserId = authorUserId;

  String? _authorName;
  String? get authorName => _$this._authorName;
  set authorName(String? authorName) => _$this._authorName = authorName;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  StudentNoteBuilder() {
    StudentNote._defaults(this);
  }

  StudentNoteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _workoutId = $v.workoutId;
      _authorUserId = $v.authorUserId;
      _authorName = $v.authorName;
      _content = $v.content;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentNote other) {
    _$v = other as _$StudentNote;
  }

  @override
  void update(void Function(StudentNoteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentNote build() => _build();

  _$StudentNote _build() {
    final _$result = _$v ??
        _$StudentNote._(
          id: id,
          workoutId: workoutId,
          authorUserId: authorUserId,
          authorName: authorName,
          content: content,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
