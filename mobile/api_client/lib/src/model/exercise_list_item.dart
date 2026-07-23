//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'exercise_list_item.g.dart';

/// ExerciseListItem
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [modalityId] 
/// * [modalityName] 
/// * [primaryMuscleGroupId] 
/// * [isAerobic] 
@BuiltValue()
abstract class ExerciseListItem implements Built<ExerciseListItem, ExerciseListItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'modalityId')
  String? get modalityId;

  @BuiltValueField(wireName: r'modalityName')
  String? get modalityName;

  @BuiltValueField(wireName: r'primaryMuscleGroupId')
  String? get primaryMuscleGroupId;

  @BuiltValueField(wireName: r'isAerobic')
  bool? get isAerobic;

  ExerciseListItem._();

  factory ExerciseListItem([void updates(ExerciseListItemBuilder b)]) = _$ExerciseListItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExerciseListItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExerciseListItem> get serializer => _$ExerciseListItemSerializer();
}

class _$ExerciseListItemSerializer implements PrimitiveSerializer<ExerciseListItem> {
  @override
  final Iterable<Type> types = const [ExerciseListItem, _$ExerciseListItem];

  @override
  final String wireName = r'ExerciseListItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExerciseListItem object, {
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
    if (object.modalityId != null) {
      yield r'modalityId';
      yield serializers.serialize(
        object.modalityId,
        specifiedType: const FullType(String),
      );
    }
    if (object.modalityName != null) {
      yield r'modalityName';
      yield serializers.serialize(
        object.modalityName,
        specifiedType: const FullType(String),
      );
    }
    if (object.primaryMuscleGroupId != null) {
      yield r'primaryMuscleGroupId';
      yield serializers.serialize(
        object.primaryMuscleGroupId,
        specifiedType: const FullType(String),
      );
    }
    if (object.isAerobic != null) {
      yield r'isAerobic';
      yield serializers.serialize(
        object.isAerobic,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExerciseListItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExerciseListItemBuilder result,
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
        case r'primaryMuscleGroupId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.primaryMuscleGroupId = valueDes;
          break;
        case r'isAerobic':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isAerobic = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExerciseListItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExerciseListItemBuilder();
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

