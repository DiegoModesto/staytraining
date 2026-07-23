// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_template.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkoutTemplate extends WorkoutTemplate {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? modalityId;
  @override
  final String? modalityName;
  @override
  final bool? isSystemDefault;
  @override
  final String? creatorNotes;
  @override
  final BuiltList<TemplateItem>? items;

  factory _$WorkoutTemplate([void Function(WorkoutTemplateBuilder)? updates]) =>
      (WorkoutTemplateBuilder()..update(updates))._build();

  _$WorkoutTemplate._(
      {this.id,
      this.name,
      this.description,
      this.modalityId,
      this.modalityName,
      this.isSystemDefault,
      this.creatorNotes,
      this.items})
      : super._();
  @override
  WorkoutTemplate rebuild(void Function(WorkoutTemplateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkoutTemplateBuilder toBuilder() => WorkoutTemplateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkoutTemplate &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        modalityId == other.modalityId &&
        modalityName == other.modalityName &&
        isSystemDefault == other.isSystemDefault &&
        creatorNotes == other.creatorNotes &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, modalityId.hashCode);
    _$hash = $jc(_$hash, modalityName.hashCode);
    _$hash = $jc(_$hash, isSystemDefault.hashCode);
    _$hash = $jc(_$hash, creatorNotes.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkoutTemplate')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('modalityId', modalityId)
          ..add('modalityName', modalityName)
          ..add('isSystemDefault', isSystemDefault)
          ..add('creatorNotes', creatorNotes)
          ..add('items', items))
        .toString();
  }
}

class WorkoutTemplateBuilder
    implements Builder<WorkoutTemplate, WorkoutTemplateBuilder> {
  _$WorkoutTemplate? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _modalityId;
  String? get modalityId => _$this._modalityId;
  set modalityId(String? modalityId) => _$this._modalityId = modalityId;

  String? _modalityName;
  String? get modalityName => _$this._modalityName;
  set modalityName(String? modalityName) => _$this._modalityName = modalityName;

  bool? _isSystemDefault;
  bool? get isSystemDefault => _$this._isSystemDefault;
  set isSystemDefault(bool? isSystemDefault) =>
      _$this._isSystemDefault = isSystemDefault;

  String? _creatorNotes;
  String? get creatorNotes => _$this._creatorNotes;
  set creatorNotes(String? creatorNotes) => _$this._creatorNotes = creatorNotes;

  ListBuilder<TemplateItem>? _items;
  ListBuilder<TemplateItem> get items =>
      _$this._items ??= ListBuilder<TemplateItem>();
  set items(ListBuilder<TemplateItem>? items) => _$this._items = items;

  WorkoutTemplateBuilder() {
    WorkoutTemplate._defaults(this);
  }

  WorkoutTemplateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _modalityId = $v.modalityId;
      _modalityName = $v.modalityName;
      _isSystemDefault = $v.isSystemDefault;
      _creatorNotes = $v.creatorNotes;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkoutTemplate other) {
    _$v = other as _$WorkoutTemplate;
  }

  @override
  void update(void Function(WorkoutTemplateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkoutTemplate build() => _build();

  _$WorkoutTemplate _build() {
    _$WorkoutTemplate _$result;
    try {
      _$result = _$v ??
          _$WorkoutTemplate._(
            id: id,
            name: name,
            description: description,
            modalityId: modalityId,
            modalityName: modalityName,
            isSystemDefault: isSystemDefault,
            creatorNotes: creatorNotes,
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'WorkoutTemplate', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
