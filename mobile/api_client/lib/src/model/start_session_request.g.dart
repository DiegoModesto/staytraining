// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_session_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StartSessionRequest extends StartSessionRequest {
  @override
  final String workoutId;

  factory _$StartSessionRequest(
          [void Function(StartSessionRequestBuilder)? updates]) =>
      (StartSessionRequestBuilder()..update(updates))._build();

  _$StartSessionRequest._({required this.workoutId}) : super._();
  @override
  StartSessionRequest rebuild(
          void Function(StartSessionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StartSessionRequestBuilder toBuilder() =>
      StartSessionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StartSessionRequest && workoutId == other.workoutId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, workoutId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StartSessionRequest')
          ..add('workoutId', workoutId))
        .toString();
  }
}

class StartSessionRequestBuilder
    implements Builder<StartSessionRequest, StartSessionRequestBuilder> {
  _$StartSessionRequest? _$v;

  String? _workoutId;
  String? get workoutId => _$this._workoutId;
  set workoutId(String? workoutId) => _$this._workoutId = workoutId;

  StartSessionRequestBuilder() {
    StartSessionRequest._defaults(this);
  }

  StartSessionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _workoutId = $v.workoutId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StartSessionRequest other) {
    _$v = other as _$StartSessionRequest;
  }

  @override
  void update(void Function(StartSessionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StartSessionRequest build() => _build();

  _$StartSessionRequest _build() {
    final _$result = _$v ??
        _$StartSessionRequest._(
          workoutId: BuiltValueNullFieldError.checkNotNull(
              workoutId, r'StartSessionRequest', 'workoutId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
