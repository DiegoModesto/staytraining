// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentDetail extends StudentDetail {
  @override
  final String? id;
  @override
  final String? userId;
  @override
  final String? fullName;
  @override
  final String? email;
  @override
  final Date? birthDate;
  @override
  final String? goals;
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
  final BuiltList<HealthApportment>? healthApportments;

  factory _$StudentDetail([void Function(StudentDetailBuilder)? updates]) =>
      (StudentDetailBuilder()..update(updates))._build();

  _$StudentDetail._(
      {this.id,
      this.userId,
      this.fullName,
      this.email,
      this.birthDate,
      this.goals,
      this.phone,
      this.emergencyPhone,
      this.bloodType,
      this.heightCm,
      this.weightKg,
      this.photoUrl,
      this.healthApportments})
      : super._();
  @override
  StudentDetail rebuild(void Function(StudentDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StudentDetailBuilder toBuilder() => StudentDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentDetail &&
        id == other.id &&
        userId == other.userId &&
        fullName == other.fullName &&
        email == other.email &&
        birthDate == other.birthDate &&
        goals == other.goals &&
        phone == other.phone &&
        emergencyPhone == other.emergencyPhone &&
        bloodType == other.bloodType &&
        heightCm == other.heightCm &&
        weightKg == other.weightKg &&
        photoUrl == other.photoUrl &&
        healthApportments == other.healthApportments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, birthDate.hashCode);
    _$hash = $jc(_$hash, goals.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, emergencyPhone.hashCode);
    _$hash = $jc(_$hash, bloodType.hashCode);
    _$hash = $jc(_$hash, heightCm.hashCode);
    _$hash = $jc(_$hash, weightKg.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, healthApportments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentDetail')
          ..add('id', id)
          ..add('userId', userId)
          ..add('fullName', fullName)
          ..add('email', email)
          ..add('birthDate', birthDate)
          ..add('goals', goals)
          ..add('phone', phone)
          ..add('emergencyPhone', emergencyPhone)
          ..add('bloodType', bloodType)
          ..add('heightCm', heightCm)
          ..add('weightKg', weightKg)
          ..add('photoUrl', photoUrl)
          ..add('healthApportments', healthApportments))
        .toString();
  }
}

class StudentDetailBuilder
    implements Builder<StudentDetail, StudentDetailBuilder> {
  _$StudentDetail? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  Date? _birthDate;
  Date? get birthDate => _$this._birthDate;
  set birthDate(Date? birthDate) => _$this._birthDate = birthDate;

  String? _goals;
  String? get goals => _$this._goals;
  set goals(String? goals) => _$this._goals = goals;

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

  ListBuilder<HealthApportment>? _healthApportments;
  ListBuilder<HealthApportment> get healthApportments =>
      _$this._healthApportments ??= ListBuilder<HealthApportment>();
  set healthApportments(ListBuilder<HealthApportment>? healthApportments) =>
      _$this._healthApportments = healthApportments;

  StudentDetailBuilder() {
    StudentDetail._defaults(this);
  }

  StudentDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _fullName = $v.fullName;
      _email = $v.email;
      _birthDate = $v.birthDate;
      _goals = $v.goals;
      _phone = $v.phone;
      _emergencyPhone = $v.emergencyPhone;
      _bloodType = $v.bloodType;
      _heightCm = $v.heightCm;
      _weightKg = $v.weightKg;
      _photoUrl = $v.photoUrl;
      _healthApportments = $v.healthApportments?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentDetail other) {
    _$v = other as _$StudentDetail;
  }

  @override
  void update(void Function(StudentDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentDetail build() => _build();

  _$StudentDetail _build() {
    _$StudentDetail _$result;
    try {
      _$result = _$v ??
          _$StudentDetail._(
            id: id,
            userId: userId,
            fullName: fullName,
            email: email,
            birthDate: birthDate,
            goals: goals,
            phone: phone,
            emergencyPhone: emergencyPhone,
            bloodType: bloodType,
            heightCm: heightCm,
            weightKg: weightKg,
            photoUrl: photoUrl,
            healthApportments: _healthApportments?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'healthApportments';
        _healthApportments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StudentDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
