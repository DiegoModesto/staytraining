// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_push_sessions_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SyncPushSessionsRequest extends SyncPushSessionsRequest {
  @override
  final BuiltList<SessionPushInput>? sessions;

  factory _$SyncPushSessionsRequest(
          [void Function(SyncPushSessionsRequestBuilder)? updates]) =>
      (SyncPushSessionsRequestBuilder()..update(updates))._build();

  _$SyncPushSessionsRequest._({this.sessions}) : super._();
  @override
  SyncPushSessionsRequest rebuild(
          void Function(SyncPushSessionsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SyncPushSessionsRequestBuilder toBuilder() =>
      SyncPushSessionsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SyncPushSessionsRequest && sessions == other.sessions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SyncPushSessionsRequest')
          ..add('sessions', sessions))
        .toString();
  }
}

class SyncPushSessionsRequestBuilder
    implements
        Builder<SyncPushSessionsRequest, SyncPushSessionsRequestBuilder> {
  _$SyncPushSessionsRequest? _$v;

  ListBuilder<SessionPushInput>? _sessions;
  ListBuilder<SessionPushInput> get sessions =>
      _$this._sessions ??= ListBuilder<SessionPushInput>();
  set sessions(ListBuilder<SessionPushInput>? sessions) =>
      _$this._sessions = sessions;

  SyncPushSessionsRequestBuilder() {
    SyncPushSessionsRequest._defaults(this);
  }

  SyncPushSessionsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessions = $v.sessions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SyncPushSessionsRequest other) {
    _$v = other as _$SyncPushSessionsRequest;
  }

  @override
  void update(void Function(SyncPushSessionsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SyncPushSessionsRequest build() => _build();

  _$SyncPushSessionsRequest _build() {
    _$SyncPushSessionsRequest _$result;
    try {
      _$result = _$v ??
          _$SyncPushSessionsRequest._(
            sessions: _sessions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sessions';
        _sessions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SyncPushSessionsRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
