// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_apportment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HealthApportment extends HealthApportment {
  @override
  final String? id;
  @override
  final String? bodyPartId;
  @override
  final String? bodyPartName;
  @override
  final String? problemTypeId;
  @override
  final String? problemTypeName;
  @override
  final String? observation;
  @override
  final DateTime? createdAt;

  factory _$HealthApportment(
          [void Function(HealthApportmentBuilder)? updates]) =>
      (HealthApportmentBuilder()..update(updates))._build();

  _$HealthApportment._(
      {this.id,
      this.bodyPartId,
      this.bodyPartName,
      this.problemTypeId,
      this.problemTypeName,
      this.observation,
      this.createdAt})
      : super._();
  @override
  HealthApportment rebuild(void Function(HealthApportmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HealthApportmentBuilder toBuilder() =>
      HealthApportmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealthApportment &&
        id == other.id &&
        bodyPartId == other.bodyPartId &&
        bodyPartName == other.bodyPartName &&
        problemTypeId == other.problemTypeId &&
        problemTypeName == other.problemTypeName &&
        observation == other.observation &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, bodyPartId.hashCode);
    _$hash = $jc(_$hash, bodyPartName.hashCode);
    _$hash = $jc(_$hash, problemTypeId.hashCode);
    _$hash = $jc(_$hash, problemTypeName.hashCode);
    _$hash = $jc(_$hash, observation.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HealthApportment')
          ..add('id', id)
          ..add('bodyPartId', bodyPartId)
          ..add('bodyPartName', bodyPartName)
          ..add('problemTypeId', problemTypeId)
          ..add('problemTypeName', problemTypeName)
          ..add('observation', observation)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class HealthApportmentBuilder
    implements Builder<HealthApportment, HealthApportmentBuilder> {
  _$HealthApportment? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _bodyPartId;
  String? get bodyPartId => _$this._bodyPartId;
  set bodyPartId(String? bodyPartId) => _$this._bodyPartId = bodyPartId;

  String? _bodyPartName;
  String? get bodyPartName => _$this._bodyPartName;
  set bodyPartName(String? bodyPartName) => _$this._bodyPartName = bodyPartName;

  String? _problemTypeId;
  String? get problemTypeId => _$this._problemTypeId;
  set problemTypeId(String? problemTypeId) =>
      _$this._problemTypeId = problemTypeId;

  String? _problemTypeName;
  String? get problemTypeName => _$this._problemTypeName;
  set problemTypeName(String? problemTypeName) =>
      _$this._problemTypeName = problemTypeName;

  String? _observation;
  String? get observation => _$this._observation;
  set observation(String? observation) => _$this._observation = observation;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  HealthApportmentBuilder() {
    HealthApportment._defaults(this);
  }

  HealthApportmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _bodyPartId = $v.bodyPartId;
      _bodyPartName = $v.bodyPartName;
      _problemTypeId = $v.problemTypeId;
      _problemTypeName = $v.problemTypeName;
      _observation = $v.observation;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthApportment other) {
    _$v = other as _$HealthApportment;
  }

  @override
  void update(void Function(HealthApportmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HealthApportment build() => _build();

  _$HealthApportment _build() {
    final _$result = _$v ??
        _$HealthApportment._(
          id: id,
          bodyPartId: bodyPartId,
          bodyPartName: bodyPartName,
          problemTypeId: problemTypeId,
          problemTypeName: problemTypeName,
          observation: observation,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
