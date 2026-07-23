// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_push_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SyncPushResult extends SyncPushResult {
  @override
  final int? sessionsInserted;
  @override
  final int? sessionsSkipped;

  factory _$SyncPushResult([void Function(SyncPushResultBuilder)? updates]) =>
      (SyncPushResultBuilder()..update(updates))._build();

  _$SyncPushResult._({this.sessionsInserted, this.sessionsSkipped}) : super._();
  @override
  SyncPushResult rebuild(void Function(SyncPushResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SyncPushResultBuilder toBuilder() => SyncPushResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SyncPushResult &&
        sessionsInserted == other.sessionsInserted &&
        sessionsSkipped == other.sessionsSkipped;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionsInserted.hashCode);
    _$hash = $jc(_$hash, sessionsSkipped.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SyncPushResult')
          ..add('sessionsInserted', sessionsInserted)
          ..add('sessionsSkipped', sessionsSkipped))
        .toString();
  }
}

class SyncPushResultBuilder
    implements Builder<SyncPushResult, SyncPushResultBuilder> {
  _$SyncPushResult? _$v;

  int? _sessionsInserted;
  int? get sessionsInserted => _$this._sessionsInserted;
  set sessionsInserted(int? sessionsInserted) =>
      _$this._sessionsInserted = sessionsInserted;

  int? _sessionsSkipped;
  int? get sessionsSkipped => _$this._sessionsSkipped;
  set sessionsSkipped(int? sessionsSkipped) =>
      _$this._sessionsSkipped = sessionsSkipped;

  SyncPushResultBuilder() {
    SyncPushResult._defaults(this);
  }

  SyncPushResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionsInserted = $v.sessionsInserted;
      _sessionsSkipped = $v.sessionsSkipped;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SyncPushResult other) {
    _$v = other as _$SyncPushResult;
  }

  @override
  void update(void Function(SyncPushResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SyncPushResult build() => _build();

  _$SyncPushResult _build() {
    final _$result = _$v ??
        _$SyncPushResult._(
          sessionsInserted: sessionsInserted,
          sessionsSkipped: sessionsSkipped,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
