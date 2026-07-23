// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_workout_from_template_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateWorkoutFromTemplateRequest
    extends CreateWorkoutFromTemplateRequest {
  @override
  final String templateId;
  @override
  final String ownerStudentId;
  @override
  final String? nameOverride;

  factory _$CreateWorkoutFromTemplateRequest(
          [void Function(CreateWorkoutFromTemplateRequestBuilder)? updates]) =>
      (CreateWorkoutFromTemplateRequestBuilder()..update(updates))._build();

  _$CreateWorkoutFromTemplateRequest._(
      {required this.templateId,
      required this.ownerStudentId,
      this.nameOverride})
      : super._();
  @override
  CreateWorkoutFromTemplateRequest rebuild(
          void Function(CreateWorkoutFromTemplateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateWorkoutFromTemplateRequestBuilder toBuilder() =>
      CreateWorkoutFromTemplateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateWorkoutFromTemplateRequest &&
        templateId == other.templateId &&
        ownerStudentId == other.ownerStudentId &&
        nameOverride == other.nameOverride;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, templateId.hashCode);
    _$hash = $jc(_$hash, ownerStudentId.hashCode);
    _$hash = $jc(_$hash, nameOverride.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateWorkoutFromTemplateRequest')
          ..add('templateId', templateId)
          ..add('ownerStudentId', ownerStudentId)
          ..add('nameOverride', nameOverride))
        .toString();
  }
}

class CreateWorkoutFromTemplateRequestBuilder
    implements
        Builder<CreateWorkoutFromTemplateRequest,
            CreateWorkoutFromTemplateRequestBuilder> {
  _$CreateWorkoutFromTemplateRequest? _$v;

  String? _templateId;
  String? get templateId => _$this._templateId;
  set templateId(String? templateId) => _$this._templateId = templateId;

  String? _ownerStudentId;
  String? get ownerStudentId => _$this._ownerStudentId;
  set ownerStudentId(String? ownerStudentId) =>
      _$this._ownerStudentId = ownerStudentId;

  String? _nameOverride;
  String? get nameOverride => _$this._nameOverride;
  set nameOverride(String? nameOverride) => _$this._nameOverride = nameOverride;

  CreateWorkoutFromTemplateRequestBuilder() {
    CreateWorkoutFromTemplateRequest._defaults(this);
  }

  CreateWorkoutFromTemplateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _templateId = $v.templateId;
      _ownerStudentId = $v.ownerStudentId;
      _nameOverride = $v.nameOverride;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateWorkoutFromTemplateRequest other) {
    _$v = other as _$CreateWorkoutFromTemplateRequest;
  }

  @override
  void update(void Function(CreateWorkoutFromTemplateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateWorkoutFromTemplateRequest build() => _build();

  _$CreateWorkoutFromTemplateRequest _build() {
    final _$result = _$v ??
        _$CreateWorkoutFromTemplateRequest._(
          templateId: BuiltValueNullFieldError.checkNotNull(
              templateId, r'CreateWorkoutFromTemplateRequest', 'templateId'),
          ownerStudentId: BuiltValueNullFieldError.checkNotNull(ownerStudentId,
              r'CreateWorkoutFromTemplateRequest', 'ownerStudentId'),
          nameOverride: nameOverride,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
