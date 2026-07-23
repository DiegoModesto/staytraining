//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workout_item_input.g.dart';

/// WorkoutItemInput
///
/// Properties:
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
@BuiltValue()
abstract class WorkoutItemInput implements Built<WorkoutItemInput, WorkoutItemInputBuilder> {
  @BuiltValueField(wireName: r'exerciseId')
  String get exerciseId;

  @BuiltValueField(wireName: r'order')
  int get order;

  @BuiltValueField(wireName: r'sectionLabel')
  String? get sectionLabel;

  @BuiltValueField(wireName: r'sets')
  int get sets;

  @BuiltValueField(wireName: r'reps')
  int get reps;

  @BuiltValueField(wireName: r'restSeconds')
  int get restSeconds;

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

  WorkoutItemInput._();

  factory WorkoutItemInput([void updates(WorkoutItemInputBuilder b)]) = _$WorkoutItemInput;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkoutItemInputBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkoutItemInput> get serializer => _$WorkoutItemInputSerializer();
}

class _$WorkoutItemInputSerializer implements PrimitiveSerializer<WorkoutItemInput> {
  @override
  final Iterable<Type> types = const [WorkoutItemInput, _$WorkoutItemInput];

  @override
  final String wireName = r'WorkoutItemInput';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkoutItemInput object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'exerciseId';
    yield serializers.serialize(
      object.exerciseId,
      specifiedType: const FullType(String),
    );
    yield r'order';
    yield serializers.serialize(
      object.order,
      specifiedType: const FullType(int),
    );
    if (object.sectionLabel != null) {
      yield r'sectionLabel';
      yield serializers.serialize(
        object.sectionLabel,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'sets';
    yield serializers.serialize(
      object.sets,
      specifiedType: const FullType(int),
    );
    yield r'reps';
    yield serializers.serialize(
      object.reps,
      specifiedType: const FullType(int),
    );
    yield r'restSeconds';
    yield serializers.serialize(
      object.restSeconds,
      specifiedType: const FullType(int),
    );
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
    WorkoutItemInput object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WorkoutItemInputBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'exerciseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.exerciseId = valueDes;
          break;
        case r'order':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
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
            specifiedType: const FullType(int),
          ) as int;
          result.sets = valueDes;
          break;
        case r'reps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.reps = valueDes;
          break;
        case r'restSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
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
  WorkoutItemInput deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkoutItemInputBuilder();
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

