//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workout_item.g.dart';

/// WorkoutItem
///
/// Properties:
/// * [id] 
/// * [exerciseId] 
/// * [order] 
/// * [sectionLabel] 
/// * [sets] 
/// * [reps] 
/// * [restSeconds] 
/// * [durationSeconds] 
/// * [workSeconds] 
/// * [intervalRestSeconds] 
/// * [rounds] 
/// * [professorComment] 
@BuiltValue(instantiable: false)
abstract class WorkoutItem  {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'exerciseId')
  String? get exerciseId;

  @BuiltValueField(wireName: r'order')
  int? get order;

  @BuiltValueField(wireName: r'sectionLabel')
  String? get sectionLabel;

  @BuiltValueField(wireName: r'sets')
  int? get sets;

  @BuiltValueField(wireName: r'reps')
  int? get reps;

  @BuiltValueField(wireName: r'restSeconds')
  int? get restSeconds;

  @BuiltValueField(wireName: r'durationSeconds')
  int? get durationSeconds;

  @BuiltValueField(wireName: r'workSeconds')
  int? get workSeconds;

  @BuiltValueField(wireName: r'intervalRestSeconds')
  int? get intervalRestSeconds;

  @BuiltValueField(wireName: r'rounds')
  int? get rounds;

  @BuiltValueField(wireName: r'professorComment')
  String? get professorComment;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkoutItem> get serializer => _$WorkoutItemSerializer();
}

class _$WorkoutItemSerializer implements PrimitiveSerializer<WorkoutItem> {
  @override
  final Iterable<Type> types = const [WorkoutItem];

  @override
  final String wireName = r'WorkoutItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkoutItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    if (object.order != null) {
      yield r'order';
      yield serializers.serialize(
        object.order,
        specifiedType: const FullType(int),
      );
    }
    if (object.sectionLabel != null) {
      yield r'sectionLabel';
      yield serializers.serialize(
        object.sectionLabel,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.sets != null) {
      yield r'sets';
      yield serializers.serialize(
        object.sets,
        specifiedType: const FullType(int),
      );
    }
    if (object.reps != null) {
      yield r'reps';
      yield serializers.serialize(
        object.reps,
        specifiedType: const FullType(int),
      );
    }
    if (object.restSeconds != null) {
      yield r'restSeconds';
      yield serializers.serialize(
        object.restSeconds,
        specifiedType: const FullType(int),
      );
    }
    if (object.durationSeconds != null) {
      yield r'durationSeconds';
      yield serializers.serialize(
        object.durationSeconds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.workSeconds != null) {
      yield r'workSeconds';
      yield serializers.serialize(
        object.workSeconds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.intervalRestSeconds != null) {
      yield r'intervalRestSeconds';
      yield serializers.serialize(
        object.intervalRestSeconds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.rounds != null) {
      yield r'rounds';
      yield serializers.serialize(
        object.rounds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.professorComment != null) {
      yield r'professorComment';
      yield serializers.serialize(
        object.professorComment,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkoutItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  WorkoutItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($WorkoutItem)) as $WorkoutItem;
  }
}

/// a concrete implementation of [WorkoutItem], since [WorkoutItem] is not instantiable
@BuiltValue(instantiable: true)
abstract class $WorkoutItem implements WorkoutItem, Built<$WorkoutItem, $WorkoutItemBuilder> {
  $WorkoutItem._();

  factory $WorkoutItem([void Function($WorkoutItemBuilder)? updates]) = _$$WorkoutItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($WorkoutItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$WorkoutItem> get serializer => _$$WorkoutItemSerializer();
}

class _$$WorkoutItemSerializer implements PrimitiveSerializer<$WorkoutItem> {
  @override
  final Iterable<Type> types = const [$WorkoutItem, _$$WorkoutItem];

  @override
  final String wireName = r'$WorkoutItem';

  @override
  Object serialize(
    Serializers serializers,
    $WorkoutItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(WorkoutItem))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WorkoutItemBuilder result,
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
        case r'exerciseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.exerciseId = valueDes;
          break;
        case r'order':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.order = valueDes;
          break;
        case r'sectionLabel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.sectionLabel = valueDes;
          break;
        case r'sets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sets = valueDes;
          break;
        case r'reps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reps = valueDes;
          break;
        case r'restSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.restSeconds = valueDes;
          break;
        case r'durationSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.durationSeconds = valueDes;
          break;
        case r'workSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.workSeconds = valueDes;
          break;
        case r'intervalRestSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.intervalRestSeconds = valueDes;
          break;
        case r'rounds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.rounds = valueDes;
          break;
        case r'professorComment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.professorComment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $WorkoutItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $WorkoutItemBuilder();
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

