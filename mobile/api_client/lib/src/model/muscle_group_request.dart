//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'muscle_group_request.g.dart';

/// MuscleGroupRequest
///
/// Properties:
/// * [name] 
/// * [bodyRegion] 
@BuiltValue()
abstract class MuscleGroupRequest implements Built<MuscleGroupRequest, MuscleGroupRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'bodyRegion')
  String get bodyRegion;

  MuscleGroupRequest._();

  factory MuscleGroupRequest([void updates(MuscleGroupRequestBuilder b)]) = _$MuscleGroupRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MuscleGroupRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MuscleGroupRequest> get serializer => _$MuscleGroupRequestSerializer();
}

class _$MuscleGroupRequestSerializer implements PrimitiveSerializer<MuscleGroupRequest> {
  @override
  final Iterable<Type> types = const [MuscleGroupRequest, _$MuscleGroupRequest];

  @override
  final String wireName = r'MuscleGroupRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MuscleGroupRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'bodyRegion';
    yield serializers.serialize(
      object.bodyRegion,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MuscleGroupRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MuscleGroupRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'bodyRegion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  MuscleGroupRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MuscleGroupRequestBuilder();
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

