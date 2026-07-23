// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_list_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkoutListItem extends WorkoutListItem {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? modalityId;
  @override
  final String? modalityName;
  @override
  final int? itemCount;

  factory _$WorkoutListItem([void Function(WorkoutListItemBuilder)? updates]) =>
      (WorkoutListItemBuilder()..update(updates))._build();

  _$WorkoutListItem._(
      {this.id, this.name, this.modalityId, this.modalityName, this.itemCount})
      : super._();
  @override
  WorkoutListItem rebuild(void Function(WorkoutListItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkoutListItemBuilder toBuilder() => WorkoutListItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkoutListItem &&
        id == other.id &&
        name == other.name &&
        modalityId == other.modalityId &&
        modalityName == other.modalityName &&
        itemCount == other.itemCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, modalityId.hashCode);
    _$hash = $jc(_$hash, modalityName.hashCode);
    _$hash = $jc(_$hash, itemCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkoutListItem')
          ..add('id', id)
          ..add('name', name)
          ..add('modalityId', modalityId)
          ..add('modalityName', modalityName)
          ..add('itemCount', itemCount))
        .toString();
  }
}

class WorkoutListItemBuilder
    implements Builder<WorkoutListItem, WorkoutListItemBuilder> {
  _$WorkoutListItem? _$v;

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

  int? _itemCount;
  int? get itemCount => _$this._itemCount;
  set itemCount(int? itemCount) => _$this._itemCount = itemCount;

  WorkoutListItemBuilder() {
    WorkoutListItem._defaults(this);
  }

  WorkoutListItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _modalityId = $v.modalityId;
      _modalityName = $v.modalityName;
      _itemCount = $v.itemCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkoutListItem other) {
    _$v = other as _$WorkoutListItem;
  }

  @override
  void update(void Function(WorkoutListItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkoutListItem build() => _build();

  _$WorkoutListItem _build() {
    final _$result = _$v ??
        _$WorkoutListItem._(
          id: id,
          name: name,
          modalityId: modalityId,
          modalityName: modalityName,
          itemCount: itemCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
