// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Profile extends Profile {
  @override
  final bool? isStudent;
  @override
  final String? fullName;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? emergencyPhone;
  @override
  final BloodType? bloodType;
  @override
  final int? heightCm;
  @override
  final num? weightKg;
  @override
  final String? photoUrl;
  @override
  final BuiltList<ProfileApportment>? apportments;

  factory _$Profile([void Function(ProfileBuilder)? updates]) =>
      (ProfileBuilder()..update(updates))._build();

  _$Profile._(
      {this.isStudent,
      this.fullName,
      this.email,
      this.phone,
      this.emergencyPhone,
      this.bloodType,
      this.heightCm,
      this.weightKg,
      this.photoUrl,
      this.apportments})
      : super._();
  @override
  Profile rebuild(void Function(ProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileBuilder toBuilder() => ProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Profile &&
        isStudent == other.isStudent &&
        fullName == other.fullName &&
        email == other.email &&
        phone == other.phone &&
        emergencyPhone == other.emergencyPhone &&
        bloodType == other.bloodType &&
        heightCm == other.heightCm &&
        weightKg == other.weightKg &&
        photoUrl == other.photoUrl &&
        apportments == other.apportments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isStudent.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, emergencyPhone.hashCode);
    _$hash = $jc(_$hash, bloodType.hashCode);
    _$hash = $jc(_$hash, heightCm.hashCode);
    _$hash = $jc(_$hash, weightKg.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, apportments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Profile')
          ..add('isStudent', isStudent)
          ..add('fullName', fullName)
          ..add('email', email)
          ..add('phone', phone)
          ..add('emergencyPhone', emergencyPhone)
          ..add('bloodType', bloodType)
          ..add('heightCm', heightCm)
          ..add('weightKg', weightKg)
          ..add('photoUrl', photoUrl)
          ..add('apportments', apportments))
        .toString();
  }
}

class ProfileBuilder implements Builder<Profile, ProfileBuilder> {
  _$Profile? _$v;

  bool? _isStudent;
  bool? get isStudent => _$this._isStudent;
  set isStudent(bool? isStudent) => _$this._isStudent = isStudent;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _emergencyPhone;
  String? get emergencyPhone => _$this._emergencyPhone;
  set emergencyPhone(String? emergencyPhone) =>
      _$this._emergencyPhone = emergencyPhone;

  BloodType? _bloodType;
  BloodType? get bloodType => _$this._bloodType;
  set bloodType(BloodType? bloodType) => _$this._bloodType = bloodType;

  int? _heightCm;
  int? get heightCm => _$this._heightCm;
  set heightCm(int? heightCm) => _$this._heightCm = heightCm;

  num? _weightKg;
  num? get weightKg => _$this._weightKg;
  set weightKg(num? weightKg) => _$this._weightKg = weightKg;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  ListBuilder<ProfileApportment>? _apportments;
  ListBuilder<ProfileApportment> get apportments =>
      _$this._apportments ??= ListBuilder<ProfileApportment>();
  set apportments(ListBuilder<ProfileApportment>? apportments) =>
      _$this._apportments = apportments;

  ProfileBuilder() {
    Profile._defaults(this);
  }

  ProfileBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isStudent = $v.isStudent;
      _fullName = $v.fullName;
      _email = $v.email;
      _phone = $v.phone;
      _emergencyPhone = $v.emergencyPhone;
      _bloodType = $v.bloodType;
      _heightCm = $v.heightCm;
      _weightKg = $v.weightKg;
      _photoUrl = $v.photoUrl;
      _apportments = $v.apportments?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Profile other) {
    _$v = other as _$Profile;
  }

  @override
  void update(void Function(ProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Profile build() => _build();

  _$Profile _build() {
    _$Profile _$result;
    try {
      _$result = _$v ??
          _$Profile._(
            isStudent: isStudent,
            fullName: fullName,
            email: email,
            phone: phone,
            emergencyPhone: emergencyPhone,
            bloodType: bloodType,
            heightCm: heightCm,
            weightKg: weightKg,
            photoUrl: photoUrl,
            apportments: _apportments?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'apportments';
        _apportments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Profile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
