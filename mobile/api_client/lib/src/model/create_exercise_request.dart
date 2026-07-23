//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:staytraining_api/src/model/exercise_media_input.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_exercise_request.g.dart';

/// CreateExerciseRequest
///
/// Properties:
/// * [name] 
/// * [description] 
/// * [modalityId] 
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
abstract class CreateExerciseRequest implements Built<CreateExerciseRequest, CreateExerciseRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'modalityId')
  String get modalityId;

  @BuiltValueField(wireName: r'primaryMuscleGroupId')
  String get primaryMuscleGroupId;

  @BuiltValueField(wireName: r'secondaryMuscleGroupIds')
  BuiltList<String>? get secondaryMuscleGroupIds;

  @BuiltValueField(wireName: r'usageExample')
  String? get usageExample;

  @BuiltValueField(wireName: r'defaultSets')
  int get defaultSets;

  @BuiltValueField(wireName: r'defaultReps')
  int get defaultReps;

  @BuiltValueField(wireName: r'defaultRestSeconds')
  int get defaultRestSeconds;

  @BuiltValueField(wireName: r'isAerobic')
  bool get isAerobic;

  @BuiltValueField(wireName: r'defaultWorkSeconds')
  int? get defaultWorkSeconds;

  @BuiltValueField(wireName: r'defaultIntervalRestSeconds')
  int? get defaultIntervalRestSeconds;

  @BuiltValueField(wireName: r'defaultRounds')
  int? get defaultRounds;

  @BuiltValueField(wireName: r'media')
  BuiltList<ExerciseMediaInput>? get media;

  CreateExerciseRequest._();

  factory CreateExerciseRequest([void updates(CreateExerciseRequestBuilder b)]) = _$CreateExerciseRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateExerciseRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateExerciseRequest> get serializer => _$CreateExerciseRequestSerializer();
}

class _$CreateExerciseRequestSerializer implements PrimitiveSerializer<CreateExerciseRequest> {
  @override
  final Iterable<Type> types = const [CreateExerciseRequest, _$CreateExerciseRequest];

  @override
  final String wireName = r'CreateExerciseRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateExerciseRequest object, {
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
    yield r'modalityId';
    yield serializers.serialize(
      object.modalityId,
      specifiedType: const FullType(String),
    );
    yield r'primaryMuscleGroupId';
    yield serializers.serialize(
      object.primaryMuscleGroupId,
      specifiedType: const FullType(String),
    );
    if (object.secondaryMuscleGroupIds != null) {
      yield r'secondaryMuscleGroupIds';
      yield serializers.serialize(
        object.secondaryMuscleGroupIds,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.usageExample != null) {
      yield r'usageExample';
      yield serializers.serialize(
        object.usageExample,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'defaultSets';
    yield serializers.serialize(
      object.defaultSets,
      specifiedType: const FullType(int),
    );
    yield r'defaultReps';
    yield serializers.serialize(
      object.defaultReps,
      specifiedType: const FullType(int),
    );
    yield r'defaultRestSeconds';
    yield serializers.serialize(
      object.defaultRestSeconds,
      specifiedType: const FullType(int),
    );
    yield r'isAerobic';
    yield serializers.serialize(
      object.isAerobic,
      specifiedType: const FullType(bool),
    );
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
        specifiedType: const FullType.nullable(BuiltList, [FullType(ExerciseMediaInput)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateExerciseRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateExerciseRequestBuilder result,
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
            specifiedType: const FullType(String),
          ) as String;
          result.modalityId = valueDes;
          break;
        case r'primaryMuscleGroupId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
            specifiedType: const FullType(int),
          ) as int;
          result.defaultSets = valueDes;
          break;
        case r'defaultReps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.defaultReps = valueDes;
          break;
        case r'defaultRestSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.defaultRestSeconds = valueDes;
          break;
        case r'isAerobic':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
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
            specifiedType: const FullType.nullable(BuiltList, [FullType(ExerciseMediaInput)]),
          ) as BuiltList<ExerciseMediaInput>?;
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
  CreateExerciseRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateExerciseRequestBuilder();
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

