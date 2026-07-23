//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/template_item_input.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_workout_template_request.g.dart';

/// CreateWorkoutTemplateRequest
///
/// Properties:
/// * [name] 
/// * [description] 
/// * [modalityId] 
/// * [isSystemDefault] 
/// * [creatorNotes] 
/// * [items] 
@BuiltValue()
abstract class CreateWorkoutTemplateRequest implements Built<CreateWorkoutTemplateRequest, CreateWorkoutTemplateRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'modalityId')
  String? get modalityId;

  @BuiltValueField(wireName: r'isSystemDefault')
  bool get isSystemDefault;

  @BuiltValueField(wireName: r'creatorNotes')
  String? get creatorNotes;

  @BuiltValueField(wireName: r'items')
  BuiltList<TemplateItemInput> get items;

  CreateWorkoutTemplateRequest._();

  factory CreateWorkoutTemplateRequest([void updates(CreateWorkoutTemplateRequestBuilder b)]) = _$CreateWorkoutTemplateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateWorkoutTemplateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateWorkoutTemplateRequest> get serializer => _$CreateWorkoutTemplateRequestSerializer();
}

class _$CreateWorkoutTemplateRequestSerializer implements PrimitiveSerializer<CreateWorkoutTemplateRequest> {
  @override
  final Iterable<Type> types = const [CreateWorkoutTemplateRequest, _$CreateWorkoutTemplateRequest];

  @override
  final String wireName = r'CreateWorkoutTemplateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateWorkoutTemplateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.modalityId != null) {
      yield r'modalityId';
      yield serializers.serialize(
        object.modalityId,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'isSystemDefault';
    yield serializers.serialize(
      object.isSystemDefault,
      specifiedType: const FullType(bool),
    );
    if (object.creatorNotes != null) {
      yield r'creatorNotes';
      yield serializers.serialize(
        object.creatorNotes,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(TemplateItemInput)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateWorkoutTemplateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateWorkoutTemplateRequestBuilder result,
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
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'modalityId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.modalityId = valueDes;
          break;
        case r'isSystemDefault':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isSystemDefault = valueDes;
          break;
        case r'creatorNotes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.creatorNotes = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TemplateItemInput)]),
          ) as BuiltList<TemplateItemInput>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateWorkoutTemplateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateWorkoutTemplateRequestBuilder();
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

