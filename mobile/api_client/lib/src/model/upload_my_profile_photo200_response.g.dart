// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_my_profile_photo200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UploadMyProfilePhoto200Response
    extends UploadMyProfilePhoto200Response {
  @override
  final String? key;
  @override
  final String? photoUrl;

  factory _$UploadMyProfilePhoto200Response(
          [void Function(UploadMyProfilePhoto200ResponseBuilder)? updates]) =>
      (UploadMyProfilePhoto200ResponseBuilder()..update(updates))._build();

  _$UploadMyProfilePhoto200Response._({this.key, this.photoUrl}) : super._();
  @override
  UploadMyProfilePhoto200Response rebuild(
          void Function(UploadMyProfilePhoto200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UploadMyProfilePhoto200ResponseBuilder toBuilder() =>
      UploadMyProfilePhoto200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UploadMyProfilePhoto200Response &&
        key == other.key &&
        photoUrl == other.photoUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UploadMyProfilePhoto200Response')
          ..add('key', key)
          ..add('photoUrl', photoUrl))
        .toString();
  }
}

class UploadMyProfilePhoto200ResponseBuilder
    implements
        Builder<UploadMyProfilePhoto200Response,
            UploadMyProfilePhoto200ResponseBuilder> {
  _$UploadMyProfilePhoto200Response? _$v;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  UploadMyProfilePhoto200ResponseBuilder() {
    UploadMyProfilePhoto200Response._defaults(this);
  }

  UploadMyProfilePhoto200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _photoUrl = $v.photoUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UploadMyProfilePhoto200Response other) {
    _$v = other as _$UploadMyProfilePhoto200Response;
  }

  @override
  void update(void Function(UploadMyProfilePhoto200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UploadMyProfilePhoto200Response build() => _build();

  _$UploadMyProfilePhoto200Response _build() {
    final _$result = _$v ??
        _$UploadMyProfilePhoto200Response._(
          key: key,
          photoUrl: photoUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
