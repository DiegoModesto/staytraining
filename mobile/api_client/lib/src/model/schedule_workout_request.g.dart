// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_workout_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScheduleWorkoutRequest extends ScheduleWorkoutRequest {
  @override
  final String workoutId;
  @override
  final Date date;

  factory _$ScheduleWorkoutRequest(
          [void Function(ScheduleWorkoutRequestBuilder)? updates]) =>
      (ScheduleWorkoutRequestBuilder()..update(updates))._build();

  _$ScheduleWorkoutRequest._({required this.workoutId, required this.date})
      : super._();
  @override
  ScheduleWorkoutRequest rebuild(
          void Function(ScheduleWorkoutRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleWorkoutRequestBuilder toBuilder() =>
      ScheduleWorkoutRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleWorkoutRequest &&
        workoutId == other.workoutId &&
        date == other.date;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, workoutId.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScheduleWorkoutRequest')
          ..add('workoutId', workoutId)
          ..add('date', date))
        .toString();
  }
}

class ScheduleWorkoutRequestBuilder
    implements Builder<ScheduleWorkoutRequest, ScheduleWorkoutRequestBuilder> {
  _$ScheduleWorkoutRequest? _$v;

  String? _workoutId;
  String? get workoutId => _$this._workoutId;
  set workoutId(String? workoutId) => _$this._workoutId = workoutId;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  ScheduleWorkoutRequestBuilder() {
    ScheduleWorkoutRequest._defaults(this);
  }

  ScheduleWorkoutRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _workoutId = $v.workoutId;
      _date = $v.date;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleWorkoutRequest other) {
    _$v = other as _$ScheduleWorkoutRequest;
  }

  @override
  void update(void Function(ScheduleWorkoutRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScheduleWorkoutRequest build() => _build();

  _$ScheduleWorkoutRequest _build() {
    final _$result = _$v ??
        _$ScheduleWorkoutRequest._(
          workoutId: BuiltValueNullFieldError.checkNotNull(
              workoutId, r'ScheduleWorkoutRequest', 'workoutId'),
          date: BuiltValueNullFieldError.checkNotNull(
              date, r'ScheduleWorkoutRequest', 'date'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
