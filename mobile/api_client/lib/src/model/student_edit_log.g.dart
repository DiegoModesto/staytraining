// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_edit_log.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentEditLog extends StudentEditLog {
  @override
  final String? id;
  @override
  final String? editorUserId;
  @override
  final String? editorName;
  @override
  final String? action;
  @override
  final String? detail;
  @override
  final DateTime? createdAt;

  factory _$StudentEditLog([void Function(StudentEditLogBuilder)? updates]) =>
      (StudentEditLogBuilder()..update(updates))._build();

  _$StudentEditLog._(
      {this.id,
      this.editorUserId,
      this.editorName,
      this.action,
      this.detail,
      this.createdAt})
      : super._();
  @override
  StudentEditLog rebuild(void Function(StudentEditLogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StudentEditLogBuilder toBuilder() => StudentEditLogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentEditLog &&
        id == other.id &&
        editorUserId == other.editorUserId &&
        editorName == other.editorName &&
        action == other.action &&
        detail == other.detail &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, editorUserId.hashCode);
    _$hash = $jc(_$hash, editorName.hashCode);
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentEditLog')
          ..add('id', id)
          ..add('editorUserId', editorUserId)
          ..add('editorName', editorName)
          ..add('action', action)
          ..add('detail', detail)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class StudentEditLogBuilder
    implements Builder<StudentEditLog, StudentEditLogBuilder> {
  _$StudentEditLog? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _editorUserId;
  String? get editorUserId => _$this._editorUserId;
  set editorUserId(String? editorUserId) => _$this._editorUserId = editorUserId;

  String? _editorName;
  String? get editorName => _$this._editorName;
  set editorName(String? editorName) => _$this._editorName = editorName;

  String? _action;
  String? get action => _$this._action;
  set action(String? action) => _$this._action = action;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  StudentEditLogBuilder() {
    StudentEditLog._defaults(this);
  }

  StudentEditLogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _editorUserId = $v.editorUserId;
      _editorName = $v.editorName;
      _action = $v.action;
      _detail = $v.detail;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentEditLog other) {
    _$v = other as _$StudentEditLog;
  }

  @override
  void update(void Function(StudentEditLogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentEditLog build() => _build();

  _$StudentEditLog _build() {
    final _$result = _$v ??
        _$StudentEditLog._(
          id: id,
          editorUserId: editorUserId,
          editorName: editorName,
          action: action,
          detail: detail,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
