// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_group.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MuscleGroup extends MuscleGroup {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? bodyRegion;

  factory _$MuscleGroup([void Function(MuscleGroupBuilder)? updates]) =>
      (MuscleGroupBuilder()..update(updates))._build();

  _$MuscleGroup._({this.id, this.name, this.bodyRegion}) : super._();
  @override
  MuscleGroup rebuild(void Function(MuscleGroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MuscleGroupBuilder toBuilder() => MuscleGroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MuscleGroup &&
        id == other.id &&
        name == other.name &&
        bodyRegion == other.bodyRegion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, bodyRegion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MuscleGroup')
          ..add('id', id)
          ..add('name', name)
          ..add('bodyRegion', bodyRegion))
        .toString();
  }
}

class MuscleGroupBuilder implements Builder<MuscleGroup, MuscleGroupBuilder> {
  _$MuscleGroup? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _bodyRegion;
  String? get bodyRegion => _$this._bodyRegion;
  set bodyRegion(String? bodyRegion) => _$this._bodyRegion = bodyRegion;

  MuscleGroupBuilder() {
    MuscleGroup._defaults(this);
  }

  MuscleGroupBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _bodyRegion = $v.bodyRegion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MuscleGroup other) {
    _$v = other as _$MuscleGroup;
  }

  @override
  void update(void Function(MuscleGroupBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MuscleGroup build() => _build();

  _$MuscleGroup _build() {
    final _$result = _$v ??
        _$MuscleGroup._(
          id: id,
          name: name,
          bodyRegion: bodyRegion,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
