// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_exercise_youtube_media_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddExerciseYoutubeMediaRequest extends AddExerciseYoutubeMediaRequest {
  @override
  final String url;

  factory _$AddExerciseYoutubeMediaRequest(
          [void Function(AddExerciseYoutubeMediaRequestBuilder)? updates]) =>
      (AddExerciseYoutubeMediaRequestBuilder()..update(updates))._build();

  _$AddExerciseYoutubeMediaRequest._({required this.url}) : super._();
  @override
  AddExerciseYoutubeMediaRequest rebuild(
          void Function(AddExerciseYoutubeMediaRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddExerciseYoutubeMediaRequestBuilder toBuilder() =>
      AddExerciseYoutubeMediaRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddExerciseYoutubeMediaRequest && url == other.url;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddExerciseYoutubeMediaRequest')
          ..add('url', url))
        .toString();
  }
}

class AddExerciseYoutubeMediaRequestBuilder
    implements
        Builder<AddExerciseYoutubeMediaRequest,
            AddExerciseYoutubeMediaRequestBuilder> {
  _$AddExerciseYoutubeMediaRequest? _$v;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  AddExerciseYoutubeMediaRequestBuilder() {
    AddExerciseYoutubeMediaRequest._defaults(this);
  }

  AddExerciseYoutubeMediaRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddExerciseYoutubeMediaRequest other) {
    _$v = other as _$AddExerciseYoutubeMediaRequest;
  }

  @override
  void update(void Function(AddExerciseYoutubeMediaRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddExerciseYoutubeMediaRequest build() => _build();

  _$AddExerciseYoutubeMediaRequest _build() {
    final _$result = _$v ??
        _$AddExerciseYoutubeMediaRequest._(
          url: BuiltValueNullFieldError.checkNotNull(
              url, r'AddExerciseYoutubeMediaRequest', 'url'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
