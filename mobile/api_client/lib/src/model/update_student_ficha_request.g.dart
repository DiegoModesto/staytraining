// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_student_ficha_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateStudentFichaRequest extends UpdateStudentFichaRequest {
  @override
  final String fullName;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? emergencyPhone;
  @override
  final BloodType bloodType;
  @override
  final int? heightCm;
  @override
  final num? weightKg;
  @override
  final String? goals;

  factory _$UpdateStudentFichaRequest(
          [void Function(UpdateStudentFichaRequestBuilder)? updates]) =>
      (UpdateStudentFichaRequestBuilder()..update(updates))._build();

  _$UpdateStudentFichaRequest._(
      {required this.fullName,
      this.email,
      this.phone,
      this.emergencyPhone,
      required this.bloodType,
      this.heightCm,
      this.weightKg,
      this.goals})
      : super._();
  @override
  UpdateStudentFichaRequest rebuild(
          void Function(UpdateStudentFichaRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateStudentFichaRequestBuilder toBuilder() =>
      UpdateStudentFichaRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateStudentFichaRequest &&
        fullName == other.fullName &&
        email == other.email &&
        phone == other.phone &&
        emergencyPhone == other.emergencyPhone &&
        bloodType == other.bloodType &&
        heightCm == other.heightCm &&
        weightKg == other.weightKg &&
        goals == other.goals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, emergencyPhone.hashCode);
    _$hash = $jc(_$hash, bloodType.hashCode);
    _$hash = $jc(_$hash, heightCm.hashCode);
    _$hash = $jc(_$hash, weightKg.hashCode);
    _$hash = $jc(_$hash, goals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateStudentFichaRequest')
          ..add('fullName', fullName)
          ..add('email', email)
          ..add('phone', phone)
          ..add('emergencyPhone', emergencyPhone)
          ..add('bloodType', bloodType)
          ..add('heightCm', heightCm)
          ..add('weightKg', weightKg)
          ..add('goals', goals))
        .toString();
  }
}

class UpdateStudentFichaRequestBuilder
    implements
        Builder<UpdateStudentFichaRequest, UpdateStudentFichaRequestBuilder> {
  _$UpdateStudentFichaRequest? _$v;

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

  String? _goals;
  String? get goals => _$this._goals;
  set goals(String? goals) => _$this._goals = goals;

  UpdateStudentFichaRequestBuilder() {
    UpdateStudentFichaRequest._defaults(this);
  }

  UpdateStudentFichaRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fullName = $v.fullName;
      _email = $v.email;
      _phone = $v.phone;
      _emergencyPhone = $v.emergencyPhone;
      _bloodType = $v.bloodType;
      _heightCm = $v.heightCm;
      _weightKg = $v.weightKg;
      _goals = $v.goals;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateStudentFichaRequest other) {
    _$v = other as _$UpdateStudentFichaRequest;
  }

  @override
  void update(void Function(UpdateStudentFichaRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateStudentFichaRequest build() => _build();

  _$UpdateStudentFichaRequest _build() {
    final _$result = _$v ??
        _$UpdateStudentFichaRequest._(
          fullName: BuiltValueNullFieldError.checkNotNull(
              fullName, r'UpdateStudentFichaRequest', 'fullName'),
          email: email,
          phone: phone,
          emergencyPhone: emergencyPhone,
          bloodType: BuiltValueNullFieldError.checkNotNull(
              bloodType, r'UpdateStudentFichaRequest', 'bloodType'),
          heightCm: heightCm,
          weightKg: weightKg,
          goals: goals,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
