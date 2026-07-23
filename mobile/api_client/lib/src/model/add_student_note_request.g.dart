// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_student_note_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddStudentNoteRequest extends AddStudentNoteRequest {
  @override
  final String content;
  @override
  final String? workoutId;

  factory _$AddStudentNoteRequest(
          [void Function(AddStudentNoteRequestBuilder)? updates]) =>
      (AddStudentNoteRequestBuilder()..update(updates))._build();

  _$AddStudentNoteRequest._({required this.content, this.workoutId})
      : super._();
  @override
  AddStudentNoteRequest rebuild(
          void Function(AddStudentNoteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddStudentNoteRequestBuilder toBuilder() =>
      AddStudentNoteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddStudentNoteRequest &&
        content == other.content &&
        workoutId == other.workoutId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, workoutId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddStudentNoteRequest')
          ..add('content', content)
          ..add('workoutId', workoutId))
        .toString();
  }
}

class AddStudentNoteRequestBuilder
    implements Builder<AddStudentNoteRequest, AddStudentNoteRequestBuilder> {
  _$AddStudentNoteRequest? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _workoutId;
  String? get workoutId => _$this._workoutId;
  set workoutId(String? workoutId) => _$this._workoutId = workoutId;

  AddStudentNoteRequestBuilder() {
    AddStudentNoteRequest._defaults(this);
  }

  AddStudentNoteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _workoutId = $v.workoutId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddStudentNoteRequest other) {
    _$v = other as _$AddStudentNoteRequest;
  }

  @override
  void update(void Function(AddStudentNoteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddStudentNoteRequest build() => _build();

  _$AddStudentNoteRequest _build() {
    final _$result = _$v ??
        _$AddStudentNoteRequest._(
          content: BuiltValueNullFieldError.checkNotNull(
              content, r'AddStudentNoteRequest', 'content'),
          workoutId: workoutId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
