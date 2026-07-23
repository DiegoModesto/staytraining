//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'health_apportment.g.dart';

/// HealthApportment
///
/// Properties:
/// * [id] 
/// * [bodyPartId] 
/// * [bodyPartName] 
/// * [problemTypeId] 
/// * [problemTypeName] 
/// * [observation] 
/// * [createdAt] 
@BuiltValue()
abstract class HealthApportment implements Built<HealthApportment, HealthApportmentBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'bodyPartId')
  String? get bodyPartId;

  @BuiltValueField(wireName: r'bodyPartName')
  String? get bodyPartName;

  @BuiltValueField(wireName: r'problemTypeId')
  String? get problemTypeId;

  @BuiltValueField(wireName: r'problemTypeName')
  String? get problemTypeName;

  @BuiltValueField(wireName: r'observation')
  String? get observation;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  HealthApportment._();

  factory HealthApportment([void updates(HealthApportmentBuilder b)]) = _$HealthApportment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HealthApportmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HealthApportment> get serializer => _$HealthApportmentSerializer();
}

class _$HealthApportmentSerializer implements PrimitiveSerializer<HealthApportment> {
  @override
  final Iterable<Type> types = const [HealthApportment, _$HealthApportment];

  @override
  final String wireName = r'HealthApportment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HealthApportment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.bodyPartId != null) {
      yield r'bodyPartId';
      yield serializers.serialize(
        object.bodyPartId,
        specifiedType: const FullType(String),
      );
    }
    if (object.bodyPartName != null) {
      yield r'bodyPartName';
      yield serializers.serialize(
        object.bodyPartName,
        specifiedType: const FullType(String),
      );
    }
    if (object.problemTypeId != null) {
      yield r'problemTypeId';
      yield serializers.serialize(
        object.problemTypeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.problemTypeName != null) {
      yield r'problemTypeName';
      yield serializers.serialize(
        object.problemTypeName,
        specifiedType: const FullType(String),
      );
    }
    if (object.observation != null) {
      yield r'observation';
      yield serializers.serialize(
        object.observation,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HealthApportment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HealthApportmentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'bodyPartId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bodyPartId = valueDes;
          break;
        case r'bodyPartName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bodyPartName = valueDes;
          break;
        case r'problemTypeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.problemTypeId = valueDes;
          break;
        case r'problemTypeName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.problemTypeName = valueDes;
          break;
        case r'observation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.observation = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HealthApportment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HealthApportmentBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

