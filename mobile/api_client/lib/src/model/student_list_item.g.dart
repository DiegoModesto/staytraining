// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_list_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentListItem extends StudentListItem {
  @override
  final String? id;
  @override
  final String? userId;
  @override
  final String? fullName;
  @override
  final String? email;

  factory _$StudentListItem([void Function(StudentListItemBuilder)? updates]) =>
      (StudentListItemBuilder()..update(updates))._build();

  _$StudentListItem._({this.id, this.userId, this.fullName, this.email})
      : super._();
  @override
  StudentListItem rebuild(void Function(StudentListItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StudentListItemBuilder toBuilder() => StudentListItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentListItem &&
        id == other.id &&
        userId == other.userId &&
        fullName == other.fullName &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentListItem')
          ..add('id', id)
          ..add('userId', userId)
          ..add('fullName', fullName)
          ..add('email', email))
        .toString();
  }
}

class StudentListItemBuilder
    implements Builder<StudentListItem, StudentListItemBuilder> {
  _$StudentListItem? _$v;

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

  StudentListItemBuilder() {
    StudentListItem._defaults(this);
  }

  StudentListItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _fullName = $v.fullName;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentListItem other) {
    _$v = other as _$StudentListItem;
  }

  @override
  void update(void Function(StudentListItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentListItem build() => _build();

  _$StudentListItem _build() {
    final _$result = _$v ??
        _$StudentListItem._(
          id: id,
          userId: userId,
          fullName: fullName,
          email: email,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
