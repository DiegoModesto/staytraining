//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'note_push_input.g.dart';

/// NotePushInput
///
/// Properties:
/// * [id] 
/// * [workoutItemId] 
/// * [exerciseId] 
/// * [loadKg] 
/// * [painFlag] 
/// * [painNote] 
/// * [comment] 
/// * [performedSets] 
/// * [performedReps] 
/// * [createdAt] 
@BuiltValue()
abstract class NotePushInput implements Built<NotePushInput, NotePushInputBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'workoutItemId')
  String? get workoutItemId;

  @BuiltValueField(wireName: r'exerciseId')
  String? get exerciseId;

  @BuiltValueField(wireName: r'loadKg')
  num? get loadKg;

  @BuiltValueField(wireName: r'painFlag')
  bool? get painFlag;

  @BuiltValueField(wireName: r'painNote')
  String? get painNote;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'performedSets')
  int? get performedSets;

  @BuiltValueField(wireName: r'performedReps')
  int? get performedReps;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  NotePushInput._();

  factory NotePushInput([void updates(NotePushInputBuilder b)]) = _$NotePushInput;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotePushInputBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotePushInput> get serializer => _$NotePushInputSerializer();
}

class _$NotePushInputSerializer implements PrimitiveSerializer<NotePushInput> {
  @override
  final Iterable<Type> types = const [NotePushInput, _$NotePushInput];

  @override
  final String wireName = r'NotePushInput';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotePushInput object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.workoutItemId != null) {
      yield r'workoutItemId';
      yield serializers.serialize(
        object.workoutItemId,
        specifiedType: const FullType(String),
      );
    }
    if (object.exerciseId != null) {
      yield r'exerciseId';
      yield serializers.serialize(
        object.exerciseId,
        specifiedType: const FullType(String),
      );
    }
    if (object.loadKg != null) {
      yield r'loadKg';
      yield serializers.serialize(
        object.loadKg,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.painFlag != null) {
      yield r'painFlag';
      yield serializers.serialize(
        object.painFlag,
        specifiedType: const FullType(bool),
      );
    }
    if (object.painNote != null) {
      yield r'painNote';
      yield serializers.serialize(
        object.painNote,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.performedSets != null) {
      yield r'performedSets';
      yield serializers.serialize(
        object.performedSets,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.performedReps != null) {
      yield r'performedReps';
      yield serializers.serialize(
        object.performedReps,
        specifiedType: const FullType.nullable(int),
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
    NotePushInput object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotePushInputBuilder result,
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
        case r'workoutItemId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.workoutItemId = valueDes;
          break;
        case r'exerciseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.exerciseId = valueDes;
          break;
        case r'loadKg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.loadKg = valueDes;
          break;
        case r'painFlag':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.painFlag = valueDes;
          break;
        case r'painNote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.painNote = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        case r'performedSets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.performedSets = valueDes;
          break;
        case r'performedReps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.performedReps = valueDes;
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
  NotePushInput deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotePushInputBuilder();
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

