//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:staytraining_api/src/model/workout_item_input.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_workout_request.g.dart';

/// CreateWorkoutRequest
///
/// Properties:
/// * [ownerStudentId] 
/// * [name] 
/// * [description] 
/// * [modalityId] 
/// * [items] 
@BuiltValue()
abstract class CreateWorkoutRequest implements Built<CreateWorkoutRequest, CreateWorkoutRequestBuilder> {
  @BuiltValueField(wireName: r'ownerStudentId')
  String get ownerStudentId;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'modalityId')
  String? get modalityId;

  @BuiltValueField(wireName: r'items')
  BuiltList<WorkoutItemInput> get items;

  CreateWorkoutRequest._();

  factory CreateWorkoutRequest([void updates(CreateWorkoutRequestBuilder b)]) = _$CreateWorkoutRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateWorkoutRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateWorkoutRequest> get serializer => _$CreateWorkoutRequestSerializer();
}

class _$CreateWorkoutRequestSerializer implements PrimitiveSerializer<CreateWorkoutRequest> {
  @override
  final Iterable<Type> types = const [CreateWorkoutRequest, _$CreateWorkoutRequest];

  @override
  final String wireName = r'CreateWorkoutRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateWorkoutRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'ownerStudentId';
    yield serializers.serialize(
      object.ownerStudentId,
      specifiedType: const FullType(String),
    );
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
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(WorkoutItemInput)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateWorkoutRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateWorkoutRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'ownerStudentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ownerStudentId = valueDes;
          break;
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
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WorkoutItemInput)]),
          ) as BuiltList<WorkoutItemInput>;
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
  CreateWorkoutRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateWorkoutRequestBuilder();
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

