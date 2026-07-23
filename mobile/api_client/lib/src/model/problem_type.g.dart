// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProblemType extends ProblemType {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final int? sortOrder;

  factory _$ProblemType([void Function(ProblemTypeBuilder)? updates]) =>
      (ProblemTypeBuilder()..update(updates))._build();

  _$ProblemType._({this.id, this.name, this.sortOrder}) : super._();
  @override
  ProblemType rebuild(void Function(ProblemTypeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProblemTypeBuilder toBuilder() => ProblemTypeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProblemType &&
        id == other.id &&
        name == other.name &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProblemType')
          ..add('id', id)
          ..add('name', name)
          ..add('sortOrder', sortOrder))
        .toString();
  }
}

class ProblemTypeBuilder implements Builder<ProblemType, ProblemTypeBuilder> {
  _$ProblemType? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  ProblemTypeBuilder() {
    ProblemType._defaults(this);
  }

  ProblemTypeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _sortOrder = $v.sortOrder;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProblemType other) {
    _$v = other as _$ProblemType;
  }

  @override
  void update(void Function(ProblemTypeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProblemType build() => _build();

  _$ProblemType _build() {
    final _$result = _$v ??
        _$ProblemType._(
          id: id,
          name: name,
          sortOrder: sortOrder,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
