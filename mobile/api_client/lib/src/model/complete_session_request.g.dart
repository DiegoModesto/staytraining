// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_session_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CompleteSessionRequest extends CompleteSessionRequest {
  @override
  final int? completionRating;
  @override
  final String? overallComment;

  factory _$CompleteSessionRequest(
          [void Function(CompleteSessionRequestBuilder)? updates]) =>
      (CompleteSessionRequestBuilder()..update(updates))._build();

  _$CompleteSessionRequest._({this.completionRating, this.overallComment})
      : super._();
  @override
  CompleteSessionRequest rebuild(
          void Function(CompleteSessionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompleteSessionRequestBuilder toBuilder() =>
      CompleteSessionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompleteSessionRequest &&
        completionRating == other.completionRating &&
        overallComment == other.overallComment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, completionRating.hashCode);
    _$hash = $jc(_$hash, overallComment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CompleteSessionRequest')
          ..add('completionRating', completionRating)
          ..add('overallComment', overallComment))
        .toString();
  }
}

class CompleteSessionRequestBuilder
    implements Builder<CompleteSessionRequest, CompleteSessionRequestBuilder> {
  _$CompleteSessionRequest? _$v;

  int? _completionRating;
  int? get completionRating => _$this._completionRating;
  set completionRating(int? completionRating) =>
      _$this._completionRating = completionRating;

  String? _overallComment;
  String? get overallComment => _$this._overallComment;
  set overallComment(String? overallComment) =>
      _$this._overallComment = overallComment;

  CompleteSessionRequestBuilder() {
    CompleteSessionRequest._defaults(this);
  }

  CompleteSessionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _completionRating = $v.completionRating;
      _overallComment = $v.overallComment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompleteSessionRequest other) {
    _$v = other as _$CompleteSessionRequest;
  }

  @override
  void update(void Function(CompleteSessionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CompleteSessionRequest build() => _build();

  _$CompleteSessionRequest _build() {
    final _$result = _$v ??
        _$CompleteSessionRequest._(
          completionRating: completionRating,
          overallComment: overallComment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
