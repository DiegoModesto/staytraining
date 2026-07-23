// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_media_kind.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ExerciseMediaKind _$number0 = const ExerciseMediaKind._('number0');
const ExerciseMediaKind _$number1 = const ExerciseMediaKind._('number1');
const ExerciseMediaKind _$number2 = const ExerciseMediaKind._('number2');
const ExerciseMediaKind _$number3 = const ExerciseMediaKind._('number3');

ExerciseMediaKind _$valueOf(String name) {
  switch (name) {
    case 'number0':
      return _$number0;
    case 'number1':
      return _$number1;
    case 'number2':
      return _$number2;
    case 'number3':
      return _$number3;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ExerciseMediaKind> _$values =
    BuiltSet<ExerciseMediaKind>(const <ExerciseMediaKind>[
  _$number0,
  _$number1,
  _$number2,
  _$number3,
]);

class _$ExerciseMediaKindMeta {
  const _$ExerciseMediaKindMeta();
  ExerciseMediaKind get number0 => _$number0;
  ExerciseMediaKind get number1 => _$number1;
  ExerciseMediaKind get number2 => _$number2;
  ExerciseMediaKind get number3 => _$number3;
  ExerciseMediaKind valueOf(String name) => _$valueOf(name);
  BuiltSet<ExerciseMediaKind> get values => _$values;
}

abstract class _$ExerciseMediaKindMixin {
  // ignore: non_constant_identifier_names
  _$ExerciseMediaKindMeta get ExerciseMediaKind =>
      const _$ExerciseMediaKindMeta();
}

Serializer<ExerciseMediaKind> _$exerciseMediaKindSerializer =
    _$ExerciseMediaKindSerializer();

class _$ExerciseMediaKindSerializer
    implements PrimitiveSerializer<ExerciseMediaKind> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number0': 0,
    'number1': 1,
    'number2': 2,
    'number3': 3,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    0: 'number0',
    1: 'number1',
    2: 'number2',
    3: 'number3',
  };

  @override
  final Iterable<Type> types = const <Type>[ExerciseMediaKind];
  @override
  final String wireName = 'ExerciseMediaKind';

  @override
  Object serialize(Serializers serializers, ExerciseMediaKind object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ExerciseMediaKind deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ExerciseMediaKind.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
