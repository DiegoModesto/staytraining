//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:staytraining_api/src/model/exercise_media.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'exercise.g.dart';

/// Exercise
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [description] 
/// * [modalityId] 
/// * [modalityName] 
/// * [primaryMuscleGroupId] 
/// * [secondaryMuscleGroupIds] 
/// * [usageExample] 
/// * [defaultSets] 
/// * [defaultReps] 
/// * [defaultRestSeconds] 
/// * [isAerobic] 
/// * [defaultWorkSeconds] 
/// * [defaultIntervalRestSeconds] 
/// * [defaultRounds] 
/// * [media] 
@BuiltValue()
abstract class Exercise implements Built<Exercise, ExerciseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'modalityId')
  String? get modalityId;

  @BuiltValueField(wireName: r'modalityName')
  String? get modalityName;

  @BuiltValueField(wireName: r'primaryMuscleGroupId')
  String? get primaryMuscleGroupId;

  @BuiltValueField(wireName: r'secondaryMuscleGroupIds')
  BuiltList<String>? get secondaryMuscleGroupIds;

  @BuiltValueField(wireName: r'usageExample')
  String? get usageExample;

  @BuiltValueField(wireName: r'defaultSets')
  int? get defaultSets;

  @BuiltValueField(wireName: r'defaultReps')
  int? get defaultReps;

  @BuiltValueField(wireName: r'defaultRestSeconds')
  int? get defaultRestSeconds;

  @BuiltValueField(wireName: r'isAerobic')
  bool? get isAerobic;

  @BuiltValueField(wireName: r'defaultWorkSeconds')
  int? get defaultWorkSeconds;

  @BuiltValueField(wireName: r'defaultIntervalRestSeconds')
  int? get defaultIntervalRestSeconds;

  @BuiltValueField(wireName: r'defaultRounds')
  int? get defaultRounds;

  @BuiltValueField(wireName: r'media')
  BuiltList<ExerciseMedia>? get media;

  Exercise._();

  factory Exercise([void updates(ExerciseBuilder b)]) = _$Exercise;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExerciseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Exercise> get serializer => _$ExerciseSerializer();
}

class _$ExerciseSerializer implements PrimitiveSerializer<Exercise> {
  @override
  final Iterable<Type> types = const [Exercise, _$Exercise];

  @override
  final String wireName = r'Exercise';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Exercise object, {
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
    if (object.secondaryMuscleGroupIds != null) {
      yield r'secondaryMuscleGroupIds';
      yield serializers.serialize(
        object.secondaryMuscleGroupIds,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.usageExample != null) {
      yield r'usageExample';
      yield serializers.serialize(
        object.usageExample,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.defaultSets != null) {
      yield r'defaultSets';
      yield serializers.serialize(
        object.defaultSets,
        specifiedType: const FullType(int),
      );
    }
    if (object.defaultReps != null) {
      yield r'defaultReps';
      yield serializers.serialize(
        object.defaultReps,
        specifiedType: const FullType(int),
      );
    }
    if (object.defaultRestSeconds != null) {
      yield r'defaultRestSeconds';
      yield serializers.serialize(
        object.defaultRestSeconds,
        specifiedType: const FullType(int),
      );
    }
    if (object.isAerobic != null) {
      yield r'isAerobic';
      yield serializers.serialize(
        object.isAerobic,
        specifiedType: const FullType(bool),
      );
    }
    if (object.defaultWorkSeconds != null) {
      yield r'defaultWorkSeconds';
      yield serializers.serialize(
        object.defaultWorkSeconds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.defaultIntervalRestSeconds != null) {
      yield r'defaultIntervalRestSeconds';
      yield serializers.serialize(
        object.defaultIntervalRestSeconds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.defaultRounds != null) {
      yield r'defaultRounds';
      yield serializers.serialize(
        object.defaultRounds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.media != null) {
      yield r'media';
      yield serializers.serialize(
        object.media,
        specifiedType: const FullType(BuiltList, [FullType(ExerciseMedia)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Exercise object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExerciseBuilder result,
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
        case r'primaryMuscleGroupId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.primaryMuscleGroupId = valueDes;
          break;
        case r'secondaryMuscleGroupIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.secondaryMuscleGroupIds.replace(valueDes);
          break;
        case r'usageExample':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.usageExample = valueDes;
          break;
        case r'defaultSets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.defaultSets = valueDes;
          break;
        case r'defaultReps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.defaultReps = valueDes;
          break;
        case r'defaultRestSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.defaultRestSeconds = valueDes;
          break;
        case r'isAerobic':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isAerobic = valueDes;
          break;
        case r'defaultWorkSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.defaultWorkSeconds = valueDes;
          break;
        case r'defaultIntervalRestSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.defaultIntervalRestSeconds = valueDes;
          break;
        case r'defaultRounds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.defaultRounds = valueDes;
          break;
        case r'media':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(ExerciseMedia)]),
          ) as BuiltList<ExerciseMedia>?;
          if (valueDes == null) continue;
          result.media.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Exercise deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExerciseBuilder();
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

