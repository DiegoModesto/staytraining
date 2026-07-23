// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_student_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegisterStudentRequest extends RegisterStudentRequest {
  @override
  final String userId;
  @override
  final String fullName;
  @override
  final String? email;
  @override
  final Date? birthDate;
  @override
  final String? goals;

  factory _$RegisterStudentRequest(
          [void Function(RegisterStudentRequestBuilder)? updates]) =>
      (RegisterStudentRequestBuilder()..update(updates))._build();

  _$RegisterStudentRequest._(
      {required this.userId,
      required this.fullName,
      this.email,
      this.birthDate,
      this.goals})
      : super._();
  @override
  RegisterStudentRequest rebuild(
          void Function(RegisterStudentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterStudentRequestBuilder toBuilder() =>
      RegisterStudentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterStudentRequest &&
        userId == other.userId &&
        fullName == other.fullName &&
        email == other.email &&
        birthDate == other.birthDate &&
        goals == other.goals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, birthDate.hashCode);
    _$hash = $jc(_$hash, goals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterStudentRequest')
          ..add('userId', userId)
          ..add('fullName', fullName)
          ..add('email', email)
          ..add('birthDate', birthDate)
          ..add('goals', goals))
        .toString();
  }
}

class RegisterStudentRequestBuilder
    implements Builder<RegisterStudentRequest, RegisterStudentRequestBuilder> {
  _$RegisterStudentRequest? _$v;

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

  RegisterStudentRequestBuilder() {
    RegisterStudentRequest._defaults(this);
  }

  RegisterStudentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _fullName = $v.fullName;
      _email = $v.email;
      _birthDate = $v.birthDate;
      _goals = $v.goals;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterStudentRequest other) {
    _$v = other as _$RegisterStudentRequest;
  }

  @override
  void update(void Function(RegisterStudentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterStudentRequest build() => _build();

  _$RegisterStudentRequest _build() {
    final _$result = _$v ??
        _$RegisterStudentRequest._(
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'RegisterStudentRequest', 'userId'),
          fullName: BuiltValueNullFieldError.checkNotNull(
              fullName, r'RegisterStudentRequest', 'fullName'),
          email: email,
          birthDate: birthDate,
          goals: goals,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
