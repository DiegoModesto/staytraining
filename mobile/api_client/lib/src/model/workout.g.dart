// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Workout extends Workout {
  @override
  final String? id;
  @override
  final String? ownerStudentId;
  @override
  final String? sourceTemplateId;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? modalityId;
  @override
  final String? modalityName;
  @override
  final BuiltList<WorkoutItem>? items;

  factory _$Workout([void Function(WorkoutBuilder)? updates]) =>
      (WorkoutBuilder()..update(updates))._build();

  _$Workout._(
      {this.id,
      this.ownerStudentId,
      this.sourceTemplateId,
      this.name,
      this.description,
      this.modalityId,
      this.modalityName,
      this.items})
      : super._();
  @override
  Workout rebuild(void Function(WorkoutBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkoutBuilder toBuilder() => WorkoutBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Workout &&
        id == other.id &&
        ownerStudentId == other.ownerStudentId &&
        sourceTemplateId == other.sourceTemplateId &&
        name == other.name &&
        description == other.description &&
        modalityId == other.modalityId &&
        modalityName == other.modalityName &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, ownerStudentId.hashCode);
    _$hash = $jc(_$hash, sourceTemplateId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, modalityId.hashCode);
    _$hash = $jc(_$hash, modalityName.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Workout')
          ..add('id', id)
          ..add('ownerStudentId', ownerStudentId)
          ..add('sourceTemplateId', sourceTemplateId)
          ..add('name', name)
          ..add('description', description)
          ..add('modalityId', modalityId)
          ..add('modalityName', modalityName)
          ..add('items', items))
        .toString();
  }
}

class WorkoutBuilder implements Builder<Workout, WorkoutBuilder> {
  _$Workout? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _ownerStudentId;
  String? get ownerStudentId => _$this._ownerStudentId;
  set ownerStudentId(String? ownerStudentId) =>
      _$this._ownerStudentId = ownerStudentId;

  String? _sourceTemplateId;
  String? get sourceTemplateId => _$this._sourceTemplateId;
  set sourceTemplateId(String? sourceTemplateId) =>
      _$this._sourceTemplateId = sourceTemplateId;

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

  ListBuilder<WorkoutItem>? _items;
  ListBuilder<WorkoutItem> get items =>
      _$this._items ??= ListBuilder<WorkoutItem>();
  set items(ListBuilder<WorkoutItem>? items) => _$this._items = items;

  WorkoutBuilder() {
    Workout._defaults(this);
  }

  WorkoutBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _ownerStudentId = $v.ownerStudentId;
      _sourceTemplateId = $v.sourceTemplateId;
      _name = $v.name;
      _description = $v.description;
      _modalityId = $v.modalityId;
      _modalityName = $v.modalityName;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Workout other) {
    _$v = other as _$Workout;
  }

  @override
  void update(void Function(WorkoutBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Workout build() => _build();

  _$Workout _build() {
    _$Workout _$result;
    try {
      _$result = _$v ??
          _$Workout._(
            id: id,
            ownerStudentId: ownerStudentId,
            sourceTemplateId: sourceTemplateId,
            name: name,
            description: description,
            modalityId: modalityId,
            modalityName: modalityName,
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Workout', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
