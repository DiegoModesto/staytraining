// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_group_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MuscleGroupRequest extends MuscleGroupRequest {
  @override
  final String name;
  @override
  final String bodyRegion;

  factory _$MuscleGroupRequest(
          [void Function(MuscleGroupRequestBuilder)? updates]) =>
      (MuscleGroupRequestBuilder()..update(updates))._build();

  _$MuscleGroupRequest._({required this.name, required this.bodyRegion})
      : super._();
  @override
  MuscleGroupRequest rebuild(
          void Function(MuscleGroupRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MuscleGroupRequestBuilder toBuilder() =>
      MuscleGroupRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MuscleGroupRequest &&
        name == other.name &&
        bodyRegion == other.bodyRegion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, bodyRegion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MuscleGroupRequest')
          ..add('name', name)
          ..add('bodyRegion', bodyRegion))
        .toString();
  }
}

class MuscleGroupRequestBuilder
    implements Builder<MuscleGroupRequest, MuscleGroupRequestBuilder> {
  _$MuscleGroupRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _bodyRegion;
  String? get bodyRegion => _$this._bodyRegion;
  set bodyRegion(String? bodyRegion) => _$this._bodyRegion = bodyRegion;

  MuscleGroupRequestBuilder() {
    MuscleGroupRequest._defaults(this);
  }

  MuscleGroupRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _bodyRegion = $v.bodyRegion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MuscleGroupRequest other) {
    _$v = other as _$MuscleGroupRequest;
  }

  @override
  void update(void Function(MuscleGroupRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MuscleGroupRequest build() => _build();

  _$MuscleGroupRequest _build() {
    final _$result = _$v ??
        _$MuscleGroupRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'MuscleGroupRequest', 'name'),
          bodyRegion: BuiltValueNullFieldError.checkNotNull(
              bodyRegion, r'MuscleGroupRequest', 'bodyRegion'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
