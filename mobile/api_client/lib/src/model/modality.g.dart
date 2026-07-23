// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modality.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Modality extends Modality {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? colorHex;
  @override
  final bool? isIntervalBased;
  @override
  final int? sortOrder;

  factory _$Modality([void Function(ModalityBuilder)? updates]) =>
      (ModalityBuilder()..update(updates))._build();

  _$Modality._(
      {this.id, this.name, this.colorHex, this.isIntervalBased, this.sortOrder})
      : super._();
  @override
  Modality rebuild(void Function(ModalityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ModalityBuilder toBuilder() => ModalityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Modality &&
        id == other.id &&
        name == other.name &&
        colorHex == other.colorHex &&
        isIntervalBased == other.isIntervalBased &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, colorHex.hashCode);
    _$hash = $jc(_$hash, isIntervalBased.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Modality')
          ..add('id', id)
          ..add('name', name)
          ..add('colorHex', colorHex)
          ..add('isIntervalBased', isIntervalBased)
          ..add('sortOrder', sortOrder))
        .toString();
  }
}

class ModalityBuilder implements Builder<Modality, ModalityBuilder> {
  _$Modality? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _colorHex;
  String? get colorHex => _$this._colorHex;
  set colorHex(String? colorHex) => _$this._colorHex = colorHex;

  bool? _isIntervalBased;
  bool? get isIntervalBased => _$this._isIntervalBased;
  set isIntervalBased(bool? isIntervalBased) =>
      _$this._isIntervalBased = isIntervalBased;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  ModalityBuilder() {
    Modality._defaults(this);
  }

  ModalityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _colorHex = $v.colorHex;
      _isIntervalBased = $v.isIntervalBased;
      _sortOrder = $v.sortOrder;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Modality other) {
    _$v = other as _$Modality;
  }

  @override
  void update(void Function(ModalityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Modality build() => _build();

  _$Modality _build() {
    final _$result = _$v ??
        _$Modality._(
          id: id,
          name: name,
          colorHex: colorHex,
          isIntervalBased: isIntervalBased,
          sortOrder: sortOrder,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
