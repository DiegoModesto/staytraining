// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_apportment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProfileApportment extends ProfileApportment {
  @override
  final String? id;
  @override
  final String? bodyPartName;
  @override
  final String? problemTypeName;
  @override
  final String? observation;

  factory _$ProfileApportment(
          [void Function(ProfileApportmentBuilder)? updates]) =>
      (ProfileApportmentBuilder()..update(updates))._build();

  _$ProfileApportment._(
      {this.id, this.bodyPartName, this.problemTypeName, this.observation})
      : super._();
  @override
  ProfileApportment rebuild(void Function(ProfileApportmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileApportmentBuilder toBuilder() =>
      ProfileApportmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileApportment &&
        id == other.id &&
        bodyPartName == other.bodyPartName &&
        problemTypeName == other.problemTypeName &&
        observation == other.observation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, bodyPartName.hashCode);
    _$hash = $jc(_$hash, problemTypeName.hashCode);
    _$hash = $jc(_$hash, observation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProfileApportment')
          ..add('id', id)
          ..add('bodyPartName', bodyPartName)
          ..add('problemTypeName', problemTypeName)
          ..add('observation', observation))
        .toString();
  }
}

class ProfileApportmentBuilder
    implements Builder<ProfileApportment, ProfileApportmentBuilder> {
  _$ProfileApportment? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _bodyPartName;
  String? get bodyPartName => _$this._bodyPartName;
  set bodyPartName(String? bodyPartName) => _$this._bodyPartName = bodyPartName;

  String? _problemTypeName;
  String? get problemTypeName => _$this._problemTypeName;
  set problemTypeName(String? problemTypeName) =>
      _$this._problemTypeName = problemTypeName;

  String? _observation;
  String? get observation => _$this._observation;
  set observation(String? observation) => _$this._observation = observation;

  ProfileApportmentBuilder() {
    ProfileApportment._defaults(this);
  }

  ProfileApportmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _bodyPartName = $v.bodyPartName;
      _problemTypeName = $v.problemTypeName;
      _observation = $v.observation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileApportment other) {
    _$v = other as _$ProfileApportment;
  }

  @override
  void update(void Function(ProfileApportmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileApportment build() => _build();

  _$ProfileApportment _build() {
    final _$result = _$v ??
        _$ProfileApportment._(
          id: id,
          bodyPartName: bodyPartName,
          problemTypeName: problemTypeName,
          observation: observation,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
