// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_sync_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScheduleSyncItem extends ScheduleSyncItem {
  @override
  final String? id;
  @override
  final Date? date;
  @override
  final String? workoutId;

  factory _$ScheduleSyncItem(
          [void Function(ScheduleSyncItemBuilder)? updates]) =>
      (ScheduleSyncItemBuilder()..update(updates))._build();

  _$ScheduleSyncItem._({this.id, this.date, this.workoutId}) : super._();
  @override
  ScheduleSyncItem rebuild(void Function(ScheduleSyncItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleSyncItemBuilder toBuilder() =>
      ScheduleSyncItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleSyncItem &&
        id == other.id &&
        date == other.date &&
        workoutId == other.workoutId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, workoutId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScheduleSyncItem')
          ..add('id', id)
          ..add('date', date)
          ..add('workoutId', workoutId))
        .toString();
  }
}

class ScheduleSyncItemBuilder
    implements Builder<ScheduleSyncItem, ScheduleSyncItemBuilder> {
  _$ScheduleSyncItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  String? _workoutId;
  String? get workoutId => _$this._workoutId;
  set workoutId(String? workoutId) => _$this._workoutId = workoutId;

  ScheduleSyncItemBuilder() {
    ScheduleSyncItem._defaults(this);
  }

  ScheduleSyncItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _date = $v.date;
      _workoutId = $v.workoutId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleSyncItem other) {
    _$v = other as _$ScheduleSyncItem;
  }

  @override
  void update(void Function(ScheduleSyncItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScheduleSyncItem build() => _build();

  _$ScheduleSyncItem _build() {
    final _$result = _$v ??
        _$ScheduleSyncItem._(
          id: id,
          date: date,
          workoutId: workoutId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
