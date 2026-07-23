// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_schedule_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WeekScheduleItem extends WeekScheduleItem {
  @override
  final String? scheduleId;
  @override
  final Date? date;
  @override
  final String? workoutId;
  @override
  final String? workoutName;

  factory _$WeekScheduleItem(
          [void Function(WeekScheduleItemBuilder)? updates]) =>
      (WeekScheduleItemBuilder()..update(updates))._build();

  _$WeekScheduleItem._(
      {this.scheduleId, this.date, this.workoutId, this.workoutName})
      : super._();
  @override
  WeekScheduleItem rebuild(void Function(WeekScheduleItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeekScheduleItemBuilder toBuilder() =>
      WeekScheduleItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeekScheduleItem &&
        scheduleId == other.scheduleId &&
        date == other.date &&
        workoutId == other.workoutId &&
        workoutName == other.workoutName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, scheduleId.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, workoutId.hashCode);
    _$hash = $jc(_$hash, workoutName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeekScheduleItem')
          ..add('scheduleId', scheduleId)
          ..add('date', date)
          ..add('workoutId', workoutId)
          ..add('workoutName', workoutName))
        .toString();
  }
}

class WeekScheduleItemBuilder
    implements Builder<WeekScheduleItem, WeekScheduleItemBuilder> {
  _$WeekScheduleItem? _$v;

  String? _scheduleId;
  String? get scheduleId => _$this._scheduleId;
  set scheduleId(String? scheduleId) => _$this._scheduleId = scheduleId;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  String? _workoutId;
  String? get workoutId => _$this._workoutId;
  set workoutId(String? workoutId) => _$this._workoutId = workoutId;

  String? _workoutName;
  String? get workoutName => _$this._workoutName;
  set workoutName(String? workoutName) => _$this._workoutName = workoutName;

  WeekScheduleItemBuilder() {
    WeekScheduleItem._defaults(this);
  }

  WeekScheduleItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _scheduleId = $v.scheduleId;
      _date = $v.date;
      _workoutId = $v.workoutId;
      _workoutName = $v.workoutName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeekScheduleItem other) {
    _$v = other as _$WeekScheduleItem;
  }

  @override
  void update(void Function(WeekScheduleItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeekScheduleItem build() => _build();

  _$WeekScheduleItem _build() {
    final _$result = _$v ??
        _$WeekScheduleItem._(
          scheduleId: scheduleId,
          date: date,
          workoutId: workoutId,
          workoutName: workoutName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
