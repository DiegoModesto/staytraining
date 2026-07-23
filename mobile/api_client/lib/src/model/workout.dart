//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:staytraining_api/src/model/workout_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workout.g.dart';

/// Workout
///
/// Properties:
/// * [id] 
/// * [ownerStudentId] 
/// * [sourceTemplateId] 
/// * [name] 
/// * [description] 
/// * [modalityId] 
/// * [modalityName] 
/// * [items] 
@BuiltValue()
abstract class Workout implements Built<Workout, WorkoutBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'ownerStudentId')
  String? get ownerStudentId;

  @BuiltValueField(wireName: r'sourceTemplateId')
  String? get sourceTemplateId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'modalityId')
  String? get modalityId;

  @BuiltValueField(wireName: r'modalityName')
  String? get modalityName;

  @BuiltValueField(wireName: r'items')
  BuiltList<WorkoutItem>? get items;

  Workout._();

  factory Workout([void updates(WorkoutBuilder b)]) = _$Workout;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkoutBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Workout> get serializer => _$WorkoutSerializer();
}

class _$WorkoutSerializer implements PrimitiveSerializer<Workout> {
  @override
  final Iterable<Type> types = const [Workout, _$Workout];

  @override
  final String wireName = r'Workout';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Workout object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.ownerStudentId != null) {
      yield r'ownerStudentId';
      yield serializers.serialize(
        object.ownerStudentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.sourceTemplateId != null) {
      yield r'sourceTemplateId';
      yield serializers.serialize(
        object.sourceTemplateId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.modalityName != null) {
      yield r'modalityName';
      yield serializers.serialize(
        object.modalityName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(WorkoutItem)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Workout object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WorkoutBuilder result,
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
        case r'ownerStudentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.ownerStudentId = valueDes;
          break;
        case r'sourceTemplateId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.sourceTemplateId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
        case r'modalityName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.modalityName = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(WorkoutItem)]),
          ) as BuiltList<WorkoutItem>?;
          if (valueDes == null) continue;
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
  Workout deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkoutBuilder();
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

