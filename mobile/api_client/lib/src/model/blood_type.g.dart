// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BloodType _$number0 = const BloodType._('number0');
const BloodType _$number1 = const BloodType._('number1');
const BloodType _$number2 = const BloodType._('number2');
const BloodType _$number3 = const BloodType._('number3');
const BloodType _$number4 = const BloodType._('number4');
const BloodType _$number5 = const BloodType._('number5');
const BloodType _$number6 = const BloodType._('number6');
const BloodType _$number7 = const BloodType._('number7');
const BloodType _$number8 = const BloodType._('number8');

BloodType _$valueOf(String name) {
  switch (name) {
    case 'number0':
      return _$number0;
    case 'number1':
      return _$number1;
    case 'number2':
      return _$number2;
    case 'number3':
      return _$number3;
    case 'number4':
      return _$number4;
    case 'number5':
      return _$number5;
    case 'number6':
      return _$number6;
    case 'number7':
      return _$number7;
    case 'number8':
      return _$number8;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BloodType> _$values = BuiltSet<BloodType>(const <BloodType>[
  _$number0,
  _$number1,
  _$number2,
  _$number3,
  _$number4,
  _$number5,
  _$number6,
  _$number7,
  _$number8,
]);

class _$BloodTypeMeta {
  const _$BloodTypeMeta();
  BloodType get number0 => _$number0;
  BloodType get number1 => _$number1;
  BloodType get number2 => _$number2;
  BloodType get number3 => _$number3;
  BloodType get number4 => _$number4;
  BloodType get number5 => _$number5;
  BloodType get number6 => _$number6;
  BloodType get number7 => _$number7;
  BloodType get number8 => _$number8;
  BloodType valueOf(String name) => _$valueOf(name);
  BuiltSet<BloodType> get values => _$values;
}

abstract class _$BloodTypeMixin {
  // ignore: non_constant_identifier_names
  _$BloodTypeMeta get BloodType => const _$BloodTypeMeta();
}

Serializer<BloodType> _$bloodTypeSerializer = _$BloodTypeSerializer();

class _$BloodTypeSerializer implements PrimitiveSerializer<BloodType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number0': 0,
    'number1': 1,
    'number2': 2,
    'number3': 3,
    'number4': 4,
    'number5': 5,
    'number6': 6,
    'number7': 7,
    'number8': 8,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    0: 'number0',
    1: 'number1',
    2: 'number2',
    3: 'number3',
    4: 'number4',
    5: 'number5',
    6: 'number6',
    7: 'number7',
    8: 'number8',
  };

  @override
  final Iterable<Type> types = const <Type>[BloodType];
  @override
  final String wireName = 'BloodType';

  @override
  Object serialize(Serializers serializers, BloodType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BloodType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BloodType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
