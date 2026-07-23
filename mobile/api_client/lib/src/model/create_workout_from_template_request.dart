//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_workout_from_template_request.g.dart';

/// CreateWorkoutFromTemplateRequest
///
/// Properties:
/// * [templateId] 
/// * [ownerStudentId] 
/// * [nameOverride] 
@BuiltValue()
abstract class CreateWorkoutFromTemplateRequest implements Built<CreateWorkoutFromTemplateRequest, CreateWorkoutFromTemplateRequestBuilder> {
  @BuiltValueField(wireName: r'templateId')
  String get templateId;

  @BuiltValueField(wireName: r'ownerStudentId')
  String get ownerStudentId;

  @BuiltValueField(wireName: r'nameOverride')
  String? get nameOverride;

  CreateWorkoutFromTemplateRequest._();

  factory CreateWorkoutFromTemplateRequest([void updates(CreateWorkoutFromTemplateRequestBuilder b)]) = _$CreateWorkoutFromTemplateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateWorkoutFromTemplateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateWorkoutFromTemplateRequest> get serializer => _$CreateWorkoutFromTemplateRequestSerializer();
}

class _$CreateWorkoutFromTemplateRequestSerializer implements PrimitiveSerializer<CreateWorkoutFromTemplateRequest> {
  @override
  final Iterable<Type> types = const [CreateWorkoutFromTemplateRequest, _$CreateWorkoutFromTemplateRequest];

  @override
  final String wireName = r'CreateWorkoutFromTemplateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateWorkoutFromTemplateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'templateId';
    yield serializers.serialize(
      object.templateId,
      specifiedType: const FullType(String),
    );
    yield r'ownerStudentId';
    yield serializers.serialize(
      object.ownerStudentId,
      specifiedType: const FullType(String),
    );
    if (object.nameOverride != null) {
      yield r'nameOverride';
      yield serializers.serialize(
        object.nameOverride,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateWorkoutFromTemplateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateWorkoutFromTemplateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'templateId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.templateId = valueDes;
          break;
        case r'ownerStudentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ownerStudentId = valueDes;
          break;
        case r'nameOverride':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nameOverride = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateWorkoutFromTemplateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateWorkoutFromTemplateRequestBuilder();
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

