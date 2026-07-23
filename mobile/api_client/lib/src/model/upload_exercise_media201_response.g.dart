// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_exercise_media201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UploadExerciseMedia201Response extends UploadExerciseMedia201Response {
  @override
  final String? id;
  @override
  final String? key;

  factory _$UploadExerciseMedia201Response(
          [void Function(UploadExerciseMedia201ResponseBuilder)? updates]) =>
      (UploadExerciseMedia201ResponseBuilder()..update(updates))._build();

  _$UploadExerciseMedia201Response._({this.id, this.key}) : super._();
  @override
  UploadExerciseMedia201Response rebuild(
          void Function(UploadExerciseMedia201ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UploadExerciseMedia201ResponseBuilder toBuilder() =>
      UploadExerciseMedia201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UploadExerciseMedia201Response &&
        id == other.id &&
        key == other.key;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UploadExerciseMedia201Response')
          ..add('id', id)
          ..add('key', key))
        .toString();
  }
}

class UploadExerciseMedia201ResponseBuilder
    implements
        Builder<UploadExerciseMedia201Response,
            UploadExerciseMedia201ResponseBuilder> {
  _$UploadExerciseMedia201Response? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  UploadExerciseMedia201ResponseBuilder() {
    UploadExerciseMedia201Response._defaults(this);
  }

  UploadExerciseMedia201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _key = $v.key;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UploadExerciseMedia201Response other) {
    _$v = other as _$UploadExerciseMedia201Response;
  }

  @override
  void update(void Function(UploadExerciseMedia201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UploadExerciseMedia201Response build() => _build();

  _$UploadExerciseMedia201Response _build() {
    final _$result = _$v ??
        _$UploadExerciseMedia201Response._(
          id: id,
          key: key,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
