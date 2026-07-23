// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modality_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ModalityRequest extends ModalityRequest {
  @override
  final String name;
  @override
  final String colorHex;
  @override
  final bool isIntervalBased;
  @override
  final int sortOrder;

  factory _$ModalityRequest([void Function(ModalityRequestBuilder)? updates]) =>
      (ModalityRequestBuilder()..update(updates))._build();

  _$ModalityRequest._(
      {required this.name,
      required this.colorHex,
      required this.isIntervalBased,
      required this.sortOrder})
      : super._();
  @override
  ModalityRequest rebuild(void Function(ModalityRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ModalityRequestBuilder toBuilder() => ModalityRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ModalityRequest &&
        name == other.name &&
        colorHex == other.colorHex &&
        isIntervalBased == other.isIntervalBased &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, colorHex.hashCode);
    _$hash = $jc(_$hash, isIntervalBased.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ModalityRequest')
          ..add('name', name)
          ..add('colorHex', colorHex)
          ..add('isIntervalBased', isIntervalBased)
          ..add('sortOrder', sortOrder))
        .toString();
  }
}

class ModalityRequestBuilder
    implements Builder<ModalityRequest, ModalityRequestBuilder> {
  _$ModalityRequest? _$v;

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

  ModalityRequestBuilder() {
    ModalityRequest._defaults(this);
  }

  ModalityRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _colorHex = $v.colorHex;
      _isIntervalBased = $v.isIntervalBased;
      _sortOrder = $v.sortOrder;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ModalityRequest other) {
    _$v = other as _$ModalityRequest;
  }

  @override
  void update(void Function(ModalityRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ModalityRequest build() => _build();

  _$ModalityRequest _build() {
    final _$result = _$v ??
        _$ModalityRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'ModalityRequest', 'name'),
          colorHex: BuiltValueNullFieldError.checkNotNull(
              colorHex, r'ModalityRequest', 'colorHex'),
          isIntervalBased: BuiltValueNullFieldError.checkNotNull(
              isIntervalBased, r'ModalityRequest', 'isIntervalBased'),
          sortOrder: BuiltValueNullFieldError.checkNotNull(
              sortOrder, r'ModalityRequest', 'sortOrder'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
