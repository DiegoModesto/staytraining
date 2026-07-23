//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/workout_template.dart';
import 'package:staytraining_api/src/model/exercise.dart';
import 'package:built_collection/built_collection.dart';
import 'package:staytraining_api/src/model/schedule_sync_item.dart';
import 'package:staytraining_api/src/model/workout.dart';
import 'package:staytraining_api/src/model/muscle_group.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sync_pull_response.g.dart';

/// SyncPullResponse
///
/// Properties:
/// * [serverTime] 
/// * [muscleGroups] 
/// * [deletedMuscleGroupIds] 
/// * [exercises] 
/// * [deletedExerciseIds] 
/// * [templates] 
/// * [deletedTemplateIds] 
/// * [workouts] 
/// * [deletedWorkoutIds] 
/// * [schedules] 
/// * [deletedScheduleIds] 
@BuiltValue()
abstract class SyncPullResponse implements Built<SyncPullResponse, SyncPullResponseBuilder> {
  @BuiltValueField(wireName: r'serverTime')
  DateTime? get serverTime;

  @BuiltValueField(wireName: r'muscleGroups')
  BuiltList<MuscleGroup>? get muscleGroups;

  @BuiltValueField(wireName: r'deletedMuscleGroupIds')
  BuiltList<String>? get deletedMuscleGroupIds;

  @BuiltValueField(wireName: r'exercises')
  BuiltList<Exercise>? get exercises;

  @BuiltValueField(wireName: r'deletedExerciseIds')
  BuiltList<String>? get deletedExerciseIds;

  @BuiltValueField(wireName: r'templates')
  BuiltList<WorkoutTemplate>? get templates;

  @BuiltValueField(wireName: r'deletedTemplateIds')
  BuiltList<String>? get deletedTemplateIds;

  @BuiltValueField(wireName: r'workouts')
  BuiltList<Workout>? get workouts;

  @BuiltValueField(wireName: r'deletedWorkoutIds')
  BuiltList<String>? get deletedWorkoutIds;

  @BuiltValueField(wireName: r'schedules')
  BuiltList<ScheduleSyncItem>? get schedules;

  @BuiltValueField(wireName: r'deletedScheduleIds')
  BuiltList<String>? get deletedScheduleIds;

  SyncPullResponse._();

  factory SyncPullResponse([void updates(SyncPullResponseBuilder b)]) = _$SyncPullResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SyncPullResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SyncPullResponse> get serializer => _$SyncPullResponseSerializer();
}

class _$SyncPullResponseSerializer implements PrimitiveSerializer<SyncPullResponse> {
  @override
  final Iterable<Type> types = const [SyncPullResponse, _$SyncPullResponse];

  @override
  final String wireName = r'SyncPullResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SyncPullResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.serverTime != null) {
      yield r'serverTime';
      yield serializers.serialize(
        object.serverTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.muscleGroups != null) {
      yield r'muscleGroups';
      yield serializers.serialize(
        object.muscleGroups,
        specifiedType: const FullType(BuiltList, [FullType(MuscleGroup)]),
      );
    }
    if (object.deletedMuscleGroupIds != null) {
      yield r'deletedMuscleGroupIds';
      yield serializers.serialize(
        object.deletedMuscleGroupIds,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.exercises != null) {
      yield r'exercises';
      yield serializers.serialize(
        object.exercises,
        specifiedType: const FullType(BuiltList, [FullType(Exercise)]),
      );
    }
    if (object.deletedExerciseIds != null) {
      yield r'deletedExerciseIds';
      yield serializers.serialize(
        object.deletedExerciseIds,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.templates != null) {
      yield r'templates';
      yield serializers.serialize(
        object.templates,
        specifiedType: const FullType(BuiltList, [FullType(WorkoutTemplate)]),
      );
    }
    if (object.deletedTemplateIds != null) {
      yield r'deletedTemplateIds';
      yield serializers.serialize(
        object.deletedTemplateIds,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.workouts != null) {
      yield r'workouts';
      yield serializers.serialize(
        object.workouts,
        specifiedType: const FullType(BuiltList, [FullType(Workout)]),
      );
    }
    if (object.deletedWorkoutIds != null) {
      yield r'deletedWorkoutIds';
      yield serializers.serialize(
        object.deletedWorkoutIds,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.schedules != null) {
      yield r'schedules';
      yield serializers.serialize(
        object.schedules,
        specifiedType: const FullType(BuiltList, [FullType(ScheduleSyncItem)]),
      );
    }
    if (object.deletedScheduleIds != null) {
      yield r'deletedScheduleIds';
      yield serializers.serialize(
        object.deletedScheduleIds,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SyncPullResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SyncPullResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'serverTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.serverTime = valueDes;
          break;
        case r'muscleGroups':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(MuscleGroup)]),
          ) as BuiltList<MuscleGroup>?;
          if (valueDes == null) continue;
          result.muscleGroups.replace(valueDes);
          break;
        case r'deletedMuscleGroupIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.deletedMuscleGroupIds.replace(valueDes);
          break;
        case r'exercises':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(Exercise)]),
          ) as BuiltList<Exercise>?;
          if (valueDes == null) continue;
          result.exercises.replace(valueDes);
          break;
        case r'deletedExerciseIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.deletedExerciseIds.replace(valueDes);
          break;
        case r'templates':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(WorkoutTemplate)]),
          ) as BuiltList<WorkoutTemplate>?;
          if (valueDes == null) continue;
          result.templates.replace(valueDes);
          break;
        case r'deletedTemplateIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.deletedTemplateIds.replace(valueDes);
          break;
        case r'workouts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(Workout)]),
          ) as BuiltList<Workout>?;
          if (valueDes == null) continue;
          result.workouts.replace(valueDes);
          break;
        case r'deletedWorkoutIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.deletedWorkoutIds.replace(valueDes);
          break;
        case r'schedules':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(ScheduleSyncItem)]),
          ) as BuiltList<ScheduleSyncItem>?;
          if (valueDes == null) continue;
          result.schedules.replace(valueDes);
          break;
        case r'deletedScheduleIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.deletedScheduleIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SyncPullResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SyncPullResponseBuilder();
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

