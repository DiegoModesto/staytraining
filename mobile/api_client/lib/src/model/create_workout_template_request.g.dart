// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_workout_template_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateWorkoutTemplateRequest extends CreateWorkoutTemplateRequest {
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? modalityId;
  @override
  final bool isSystemDefault;
  @override
  final String? creatorNotes;
  @override
  final BuiltList<TemplateItemInput> items;

  factory _$CreateWorkoutTemplateRequest(
          [void Function(CreateWorkoutTemplateRequestBuilder)? updates]) =>
      (CreateWorkoutTemplateRequestBuilder()..update(updates))._build();

  _$CreateWorkoutTemplateRequest._(
      {required this.name,
      this.description,
      this.modalityId,
      required this.isSystemDefault,
      this.creatorNotes,
      required this.items})
      : super._();
  @override
  CreateWorkoutTemplateRequest rebuild(
          void Function(CreateWorkoutTemplateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateWorkoutTemplateRequestBuilder toBuilder() =>
      CreateWorkoutTemplateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateWorkoutTemplateRequest &&
        name == other.name &&
        description == other.description &&
        modalityId == other.modalityId &&
        isSystemDefault == other.isSystemDefault &&
        creatorNotes == other.creatorNotes &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, modalityId.hashCode);
    _$hash = $jc(_$hash, isSystemDefault.hashCode);
    _$hash = $jc(_$hash, creatorNotes.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateWorkoutTemplateRequest')
          ..add('name', name)
          ..add('description', description)
          ..add('modalityId', modalityId)
          ..add('isSystemDefault', isSystemDefault)
          ..add('creatorNotes', creatorNotes)
          ..add('items', items))
        .toString();
  }
}

class CreateWorkoutTemplateRequestBuilder
    implements
        Builder<CreateWorkoutTemplateRequest,
            CreateWorkoutTemplateRequestBuilder> {
  _$CreateWorkoutTemplateRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _modalityId;
  String? get modalityId => _$this._modalityId;
  set modalityId(String? modalityId) => _$this._modalityId = modalityId;

  bool? _isSystemDefault;
  bool? get isSystemDefault => _$this._isSystemDefault;
  set isSystemDefault(bool? isSystemDefault) =>
      _$this._isSystemDefault = isSystemDefault;

  String? _creatorNotes;
  String? get creatorNotes => _$this._creatorNotes;
  set creatorNotes(String? creatorNotes) => _$this._creatorNotes = creatorNotes;

  ListBuilder<TemplateItemInput>? _items;
  ListBuilder<TemplateItemInput> get items =>
      _$this._items ??= ListBuilder<TemplateItemInput>();
  set items(ListBuilder<TemplateItemInput>? items) => _$this._items = items;

  CreateWorkoutTemplateRequestBuilder() {
    CreateWorkoutTemplateRequest._defaults(this);
  }

  CreateWorkoutTemplateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _modalityId = $v.modalityId;
      _isSystemDefault = $v.isSystemDefault;
      _creatorNotes = $v.creatorNotes;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateWorkoutTemplateRequest other) {
    _$v = other as _$CreateWorkoutTemplateRequest;
  }

  @override
  void update(void Function(CreateWorkoutTemplateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateWorkoutTemplateRequest build() => _build();

  _$CreateWorkoutTemplateRequest _build() {
    _$CreateWorkoutTemplateRequest _$result;
    try {
      _$result = _$v ??
          _$CreateWorkoutTemplateRequest._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'CreateWorkoutTemplateRequest', 'name'),
            description: description,
            modalityId: modalityId,
            isSystemDefault: BuiltValueNullFieldError.checkNotNull(
                isSystemDefault,
                r'CreateWorkoutTemplateRequest',
                'isSystemDefault'),
            creatorNotes: creatorNotes,
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateWorkoutTemplateRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
