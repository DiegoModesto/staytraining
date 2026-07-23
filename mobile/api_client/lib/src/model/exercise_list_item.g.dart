// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_list_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExerciseListItem extends ExerciseListItem {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? modalityId;
  @override
  final String? modalityName;
  @override
  final String? primaryMuscleGroupId;
  @override
  final bool? isAerobic;

  factory _$ExerciseListItem(
          [void Function(ExerciseListItemBuilder)? updates]) =>
      (ExerciseListItemBuilder()..update(updates))._build();

  _$ExerciseListItem._(
      {this.id,
      this.name,
      this.modalityId,
      this.modalityName,
      this.primaryMuscleGroupId,
      this.isAerobic})
      : super._();
  @override
  ExerciseListItem rebuild(void Function(ExerciseListItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExerciseListItemBuilder toBuilder() =>
      ExerciseListItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExerciseListItem &&
        id == other.id &&
        name == other.name &&
        modalityId == other.modalityId &&
        modalityName == other.modalityName &&
        primaryMuscleGroupId == other.primaryMuscleGroupId &&
        isAerobic == other.isAerobic;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, modalityId.hashCode);
    _$hash = $jc(_$hash, modalityName.hashCode);
    _$hash = $jc(_$hash, primaryMuscleGroupId.hashCode);
    _$hash = $jc(_$hash, isAerobic.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExerciseListItem')
          ..add('id', id)
          ..add('name', name)
          ..add('modalityId', modalityId)
          ..add('modalityName', modalityName)
          ..add('primaryMuscleGroupId', primaryMuscleGroupId)
          ..add('isAerobic', isAerobic))
        .toString();
  }
}

class ExerciseListItemBuilder
    implements Builder<ExerciseListItem, ExerciseListItemBuilder> {
  _$ExerciseListItem? _$v;

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

  String? _primaryMuscleGroupId;
  String? get primaryMuscleGroupId => _$this._primaryMuscleGroupId;
  set primaryMuscleGroupId(String? primaryMuscleGroupId) =>
      _$this._primaryMuscleGroupId = primaryMuscleGroupId;

  bool? _isAerobic;
  bool? get isAerobic => _$this._isAerobic;
  set isAerobic(bool? isAerobic) => _$this._isAerobic = isAerobic;

  ExerciseListItemBuilder() {
    ExerciseListItem._defaults(this);
  }

  ExerciseListItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _modalityId = $v.modalityId;
      _modalityName = $v.modalityName;
      _primaryMuscleGroupId = $v.primaryMuscleGroupId;
      _isAerobic = $v.isAerobic;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExerciseListItem other) {
    _$v = other as _$ExerciseListItem;
  }

  @override
  void update(void Function(ExerciseListItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExerciseListItem build() => _build();

  _$ExerciseListItem _build() {
    final _$result = _$v ??
        _$ExerciseListItem._(
          id: id,
          name: name,
          modalityId: modalityId,
          modalityName: modalityName,
          primaryMuscleGroupId: primaryMuscleGroupId,
          isAerobic: isAerobic,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
