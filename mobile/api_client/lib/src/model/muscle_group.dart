//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'muscle_group.g.dart';

/// MuscleGroup
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [bodyRegion] 
@BuiltValue()
abstract class MuscleGroup implements Built<MuscleGroup, MuscleGroupBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'bodyRegion')
  String? get bodyRegion;

  MuscleGroup._();

  factory MuscleGroup([void updates(MuscleGroupBuilder b)]) = _$MuscleGroup;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MuscleGroupBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MuscleGroup> get serializer => _$MuscleGroupSerializer();
}

class _$MuscleGroupSerializer implements PrimitiveSerializer<MuscleGroup> {
  @override
  final Iterable<Type> types = const [MuscleGroup, _$MuscleGroup];

  @override
  final String wireName = r'MuscleGroup';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MuscleGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.bodyRegion != null) {
      yield r'bodyRegion';
      yield serializers.serialize(
        object.bodyRegion,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MuscleGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MuscleGroupBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'bodyRegion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bodyRegion = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MuscleGroup deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MuscleGroupBuilder();
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

