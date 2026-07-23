//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_problem_type_request.g.dart';

/// CreateProblemTypeRequest
///
/// Properties:
/// * [bodyPartId] 
/// * [name] 
@BuiltValue()
abstract class CreateProblemTypeRequest implements Built<CreateProblemTypeRequest, CreateProblemTypeRequestBuilder> {
  @BuiltValueField(wireName: r'bodyPartId')
  String get bodyPartId;

  @BuiltValueField(wireName: r'name')
  String get name;

  CreateProblemTypeRequest._();

  factory CreateProblemTypeRequest([void updates(CreateProblemTypeRequestBuilder b)]) = _$CreateProblemTypeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateProblemTypeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateProblemTypeRequest> get serializer => _$CreateProblemTypeRequestSerializer();
}

class _$CreateProblemTypeRequestSerializer implements PrimitiveSerializer<CreateProblemTypeRequest> {
  @override
  final Iterable<Type> types = const [CreateProblemTypeRequest, _$CreateProblemTypeRequest];

  @override
  final String wireName = r'CreateProblemTypeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateProblemTypeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'bodyPartId';
    yield serializers.serialize(
      object.bodyPartId,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateProblemTypeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateProblemTypeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'bodyPartId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.bodyPartId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateProblemTypeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateProblemTypeRequestBuilder();
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

