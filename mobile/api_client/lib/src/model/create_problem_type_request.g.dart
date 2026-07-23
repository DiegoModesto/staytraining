// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_problem_type_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateProblemTypeRequest extends CreateProblemTypeRequest {
  @override
  final String bodyPartId;
  @override
  final String name;

  factory _$CreateProblemTypeRequest(
          [void Function(CreateProblemTypeRequestBuilder)? updates]) =>
      (CreateProblemTypeRequestBuilder()..update(updates))._build();

  _$CreateProblemTypeRequest._({required this.bodyPartId, required this.name})
      : super._();
  @override
  CreateProblemTypeRequest rebuild(
          void Function(CreateProblemTypeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateProblemTypeRequestBuilder toBuilder() =>
      CreateProblemTypeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateProblemTypeRequest &&
        bodyPartId == other.bodyPartId &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bodyPartId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateProblemTypeRequest')
          ..add('bodyPartId', bodyPartId)
          ..add('name', name))
        .toString();
  }
}

class CreateProblemTypeRequestBuilder
    implements
        Builder<CreateProblemTypeRequest, CreateProblemTypeRequestBuilder> {
  _$CreateProblemTypeRequest? _$v;

  String? _bodyPartId;
  String? get bodyPartId => _$this._bodyPartId;
  set bodyPartId(String? bodyPartId) => _$this._bodyPartId = bodyPartId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CreateProblemTypeRequestBuilder() {
    CreateProblemTypeRequest._defaults(this);
  }

  CreateProblemTypeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bodyPartId = $v.bodyPartId;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateProblemTypeRequest other) {
    _$v = other as _$CreateProblemTypeRequest;
  }

  @override
  void update(void Function(CreateProblemTypeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateProblemTypeRequest build() => _build();

  _$CreateProblemTypeRequest _build() {
    final _$result = _$v ??
        _$CreateProblemTypeRequest._(
          bodyPartId: BuiltValueNullFieldError.checkNotNull(
              bodyPartId, r'CreateProblemTypeRequest', 'bodyPartId'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CreateProblemTypeRequest', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
