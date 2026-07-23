// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_apportment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddApportmentRequest extends AddApportmentRequest {
  @override
  final String bodyPartId;
  @override
  final String problemTypeId;
  @override
  final String? observation;

  factory _$AddApportmentRequest(
          [void Function(AddApportmentRequestBuilder)? updates]) =>
      (AddApportmentRequestBuilder()..update(updates))._build();

  _$AddApportmentRequest._(
      {required this.bodyPartId, required this.problemTypeId, this.observation})
      : super._();
  @override
  AddApportmentRequest rebuild(
          void Function(AddApportmentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddApportmentRequestBuilder toBuilder() =>
      AddApportmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddApportmentRequest &&
        bodyPartId == other.bodyPartId &&
        problemTypeId == other.problemTypeId &&
        observation == other.observation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bodyPartId.hashCode);
    _$hash = $jc(_$hash, problemTypeId.hashCode);
    _$hash = $jc(_$hash, observation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddApportmentRequest')
          ..add('bodyPartId', bodyPartId)
          ..add('problemTypeId', problemTypeId)
          ..add('observation', observation))
        .toString();
  }
}

class AddApportmentRequestBuilder
    implements Builder<AddApportmentRequest, AddApportmentRequestBuilder> {
  _$AddApportmentRequest? _$v;

  String? _bodyPartId;
  String? get bodyPartId => _$this._bodyPartId;
  set bodyPartId(String? bodyPartId) => _$this._bodyPartId = bodyPartId;

  String? _problemTypeId;
  String? get problemTypeId => _$this._problemTypeId;
  set problemTypeId(String? problemTypeId) =>
      _$this._problemTypeId = problemTypeId;

  String? _observation;
  String? get observation => _$this._observation;
  set observation(String? observation) => _$this._observation = observation;

  AddApportmentRequestBuilder() {
    AddApportmentRequest._defaults(this);
  }

  AddApportmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bodyPartId = $v.bodyPartId;
      _problemTypeId = $v.problemTypeId;
      _observation = $v.observation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddApportmentRequest other) {
    _$v = other as _$AddApportmentRequest;
  }

  @override
  void update(void Function(AddApportmentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddApportmentRequest build() => _build();

  _$AddApportmentRequest _build() {
    final _$result = _$v ??
        _$AddApportmentRequest._(
          bodyPartId: BuiltValueNullFieldError.checkNotNull(
              bodyPartId, r'AddApportmentRequest', 'bodyPartId'),
          problemTypeId: BuiltValueNullFieldError.checkNotNull(
              problemTypeId, r'AddApportmentRequest', 'problemTypeId'),
          observation: observation,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
