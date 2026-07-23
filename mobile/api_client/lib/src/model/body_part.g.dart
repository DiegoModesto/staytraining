// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_part.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BodyPart extends BodyPart {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final int? sortOrder;
  @override
  final BuiltList<ProblemType>? problemTypes;

  factory _$BodyPart([void Function(BodyPartBuilder)? updates]) =>
      (BodyPartBuilder()..update(updates))._build();

  _$BodyPart._({this.id, this.name, this.sortOrder, this.problemTypes})
      : super._();
  @override
  BodyPart rebuild(void Function(BodyPartBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BodyPartBuilder toBuilder() => BodyPartBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BodyPart &&
        id == other.id &&
        name == other.name &&
        sortOrder == other.sortOrder &&
        problemTypes == other.problemTypes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jc(_$hash, problemTypes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BodyPart')
          ..add('id', id)
          ..add('name', name)
          ..add('sortOrder', sortOrder)
          ..add('problemTypes', problemTypes))
        .toString();
  }
}

class BodyPartBuilder implements Builder<BodyPart, BodyPartBuilder> {
  _$BodyPart? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  ListBuilder<ProblemType>? _problemTypes;
  ListBuilder<ProblemType> get problemTypes =>
      _$this._problemTypes ??= ListBuilder<ProblemType>();
  set problemTypes(ListBuilder<ProblemType>? problemTypes) =>
      _$this._problemTypes = problemTypes;

  BodyPartBuilder() {
    BodyPart._defaults(this);
  }

  BodyPartBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _sortOrder = $v.sortOrder;
      _problemTypes = $v.problemTypes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BodyPart other) {
    _$v = other as _$BodyPart;
  }

  @override
  void update(void Function(BodyPartBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BodyPart build() => _build();

  _$BodyPart _build() {
    _$BodyPart _$result;
    try {
      _$result = _$v ??
          _$BodyPart._(
            id: id,
            name: name,
            sortOrder: sortOrder,
            problemTypes: _problemTypes?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'problemTypes';
        _problemTypes?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BodyPart', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
