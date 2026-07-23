// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_template_list_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkoutTemplateListItem extends WorkoutTemplateListItem {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? modalityId;
  @override
  final String? modalityName;
  @override
  final bool? isSystemDefault;
  @override
  final int? itemCount;

  factory _$WorkoutTemplateListItem(
          [void Function(WorkoutTemplateListItemBuilder)? updates]) =>
      (WorkoutTemplateListItemBuilder()..update(updates))._build();

  _$WorkoutTemplateListItem._(
      {this.id,
      this.name,
      this.modalityId,
      this.modalityName,
      this.isSystemDefault,
      this.itemCount})
      : super._();
  @override
  WorkoutTemplateListItem rebuild(
          void Function(WorkoutTemplateListItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkoutTemplateListItemBuilder toBuilder() =>
      WorkoutTemplateListItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkoutTemplateListItem &&
        id == other.id &&
        name == other.name &&
        modalityId == other.modalityId &&
        modalityName == other.modalityName &&
        isSystemDefault == other.isSystemDefault &&
        itemCount == other.itemCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, modalityId.hashCode);
    _$hash = $jc(_$hash, modalityName.hashCode);
    _$hash = $jc(_$hash, isSystemDefault.hashCode);
    _$hash = $jc(_$hash, itemCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkoutTemplateListItem')
          ..add('id', id)
          ..add('name', name)
          ..add('modalityId', modalityId)
          ..add('modalityName', modalityName)
          ..add('isSystemDefault', isSystemDefault)
          ..add('itemCount', itemCount))
        .toString();
  }
}

class WorkoutTemplateListItemBuilder
    implements
        Builder<WorkoutTemplateListItem, WorkoutTemplateListItemBuilder> {
  _$WorkoutTemplateListItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

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

  int? _itemCount;
  int? get itemCount => _$this._itemCount;
  set itemCount(int? itemCount) => _$this._itemCount = itemCount;

  WorkoutTemplateListItemBuilder() {
    WorkoutTemplateListItem._defaults(this);
  }

  WorkoutTemplateListItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _modalityId = $v.modalityId;
      _modalityName = $v.modalityName;
      _isSystemDefault = $v.isSystemDefault;
      _itemCount = $v.itemCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkoutTemplateListItem other) {
    _$v = other as _$WorkoutTemplateListItem;
  }

  @override
  void update(void Function(WorkoutTemplateListItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkoutTemplateListItem build() => _build();

  _$WorkoutTemplateListItem _build() {
    final _$result = _$v ??
        _$WorkoutTemplateListItem._(
          id: id,
          name: name,
          modalityId: modalityId,
          modalityName: modalityName,
          isSystemDefault: isSystemDefault,
          itemCount: itemCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
