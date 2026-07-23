// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_workout_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateWorkoutRequest extends CreateWorkoutRequest {
  @override
  final String ownerStudentId;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? modalityId;
  @override
  final BuiltList<WorkoutItemInput> items;

  factory _$CreateWorkoutRequest(
          [void Function(CreateWorkoutRequestBuilder)? updates]) =>
      (CreateWorkoutRequestBuilder()..update(updates))._build();

  _$CreateWorkoutRequest._(
      {required this.ownerStudentId,
      required this.name,
      this.description,
      this.modalityId,
      required this.items})
      : super._();
  @override
  CreateWorkoutRequest rebuild(
          void Function(CreateWorkoutRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateWorkoutRequestBuilder toBuilder() =>
      CreateWorkoutRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateWorkoutRequest &&
        ownerStudentId == other.ownerStudentId &&
        name == other.name &&
        description == other.description &&
        modalityId == other.modalityId &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ownerStudentId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, modalityId.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateWorkoutRequest')
          ..add('ownerStudentId', ownerStudentId)
          ..add('name', name)
          ..add('description', description)
          ..add('modalityId', modalityId)
          ..add('items', items))
        .toString();
  }
}

class CreateWorkoutRequestBuilder
    implements Builder<CreateWorkoutRequest, CreateWorkoutRequestBuilder> {
  _$CreateWorkoutRequest? _$v;

  String? _ownerStudentId;
  String? get ownerStudentId => _$this._ownerStudentId;
  set ownerStudentId(String? ownerStudentId) =>
      _$this._ownerStudentId = ownerStudentId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _modalityId;
  String? get modalityId => _$this._modalityId;
  set modalityId(String? modalityId) => _$this._modalityId = modalityId;

  ListBuilder<WorkoutItemInput>? _items;
  ListBuilder<WorkoutItemInput> get items =>
      _$this._items ??= ListBuilder<WorkoutItemInput>();
  set items(ListBuilder<WorkoutItemInput>? items) => _$this._items = items;

  CreateWorkoutRequestBuilder() {
    CreateWorkoutRequest._defaults(this);
  }

  CreateWorkoutRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ownerStudentId = $v.ownerStudentId;
      _name = $v.name;
      _description = $v.description;
      _modalityId = $v.modalityId;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateWorkoutRequest other) {
    _$v = other as _$CreateWorkoutRequest;
  }

  @override
  void update(void Function(CreateWorkoutRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateWorkoutRequest build() => _build();

  _$CreateWorkoutRequest _build() {
    _$CreateWorkoutRequest _$result;
    try {
      _$result = _$v ??
          _$CreateWorkoutRequest._(
            ownerStudentId: BuiltValueNullFieldError.checkNotNull(
                ownerStudentId, r'CreateWorkoutRequest', 'ownerStudentId'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'CreateWorkoutRequest', 'name'),
            description: description,
            modalityId: modalityId,
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateWorkoutRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
