// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'name_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NameRequest extends NameRequest {
  @override
  final String name;

  factory _$NameRequest([void Function(NameRequestBuilder)? updates]) =>
      (NameRequestBuilder()..update(updates))._build();

  _$NameRequest._({required this.name}) : super._();
  @override
  NameRequest rebuild(void Function(NameRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NameRequestBuilder toBuilder() => NameRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NameRequest && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NameRequest')..add('name', name))
        .toString();
  }
}

class NameRequestBuilder implements Builder<NameRequest, NameRequestBuilder> {
  _$NameRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  NameRequestBuilder() {
    NameRequest._defaults(this);
  }

  NameRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NameRequest other) {
    _$v = other as _$NameRequest;
  }

  @override
  void update(void Function(NameRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NameRequest build() => _build();

  _$NameRequest _build() {
    final _$result = _$v ??
        _$NameRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'NameRequest', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
