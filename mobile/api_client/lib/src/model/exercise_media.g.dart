// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_media.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExerciseMedia extends ExerciseMedia {
  @override
  final String? id;
  @override
  final ExerciseMediaKind? kind;
  @override
  final String? storageKey;
  @override
  final String? url;
  @override
  final String? contentType;
  @override
  final int? sizeBytes;

  factory _$ExerciseMedia([void Function(ExerciseMediaBuilder)? updates]) =>
      (ExerciseMediaBuilder()..update(updates))._build();

  _$ExerciseMedia._(
      {this.id,
      this.kind,
      this.storageKey,
      this.url,
      this.contentType,
      this.sizeBytes})
      : super._();
  @override
  ExerciseMedia rebuild(void Function(ExerciseMediaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExerciseMediaBuilder toBuilder() => ExerciseMediaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExerciseMedia &&
        id == other.id &&
        kind == other.kind &&
        storageKey == other.storageKey &&
        url == other.url &&
        contentType == other.contentType &&
        sizeBytes == other.sizeBytes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, storageKey.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, contentType.hashCode);
    _$hash = $jc(_$hash, sizeBytes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExerciseMedia')
          ..add('id', id)
          ..add('kind', kind)
          ..add('storageKey', storageKey)
          ..add('url', url)
          ..add('contentType', contentType)
          ..add('sizeBytes', sizeBytes))
        .toString();
  }
}

class ExerciseMediaBuilder
    implements Builder<ExerciseMedia, ExerciseMediaBuilder> {
  _$ExerciseMedia? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ExerciseMediaKind? _kind;
  ExerciseMediaKind? get kind => _$this._kind;
  set kind(ExerciseMediaKind? kind) => _$this._kind = kind;

  String? _storageKey;
  String? get storageKey => _$this._storageKey;
  set storageKey(String? storageKey) => _$this._storageKey = storageKey;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _contentType;
  String? get contentType => _$this._contentType;
  set contentType(String? contentType) => _$this._contentType = contentType;

  int? _sizeBytes;
  int? get sizeBytes => _$this._sizeBytes;
  set sizeBytes(int? sizeBytes) => _$this._sizeBytes = sizeBytes;

  ExerciseMediaBuilder() {
    ExerciseMedia._defaults(this);
  }

  ExerciseMediaBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _kind = $v.kind;
      _storageKey = $v.storageKey;
      _url = $v.url;
      _contentType = $v.contentType;
      _sizeBytes = $v.sizeBytes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExerciseMedia other) {
    _$v = other as _$ExerciseMedia;
  }

  @override
  void update(void Function(ExerciseMediaBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExerciseMedia build() => _build();

  _$ExerciseMedia _build() {
    final _$result = _$v ??
        _$ExerciseMedia._(
          id: id,
          kind: kind,
          storageKey: storageKey,
          url: url,
          contentType: contentType,
          sizeBytes: sizeBytes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
