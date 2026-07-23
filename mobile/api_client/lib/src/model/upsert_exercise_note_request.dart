//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upsert_exercise_note_request.g.dart';

/// UpsertExerciseNoteRequest
///
/// Properties:
/// * [workoutItemId] 
/// * [exerciseId] 
/// * [loadKg] 
/// * [painFlag] 
/// * [painNote] 
/// * [comment] 
/// * [performedSets] 
/// * [performedReps] 
@BuiltValue()
abstract class UpsertExerciseNoteRequest implements Built<UpsertExerciseNoteRequest, UpsertExerciseNoteRequestBuilder> {
  @BuiltValueField(wireName: r'workoutItemId')
  String get workoutItemId;

  @BuiltValueField(wireName: r'exerciseId')
  String get exerciseId;

  @BuiltValueField(wireName: r'loadKg')
  num? get loadKg;

  @BuiltValueField(wireName: r'painFlag')
  bool get painFlag;

  @BuiltValueField(wireName: r'painNote')
  String? get painNote;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'performedSets')
  int? get performedSets;

  @BuiltValueField(wireName: r'performedReps')
  int? get performedReps;

  UpsertExerciseNoteRequest._();

  factory UpsertExerciseNoteRequest([void updates(UpsertExerciseNoteRequestBuilder b)]) = _$UpsertExerciseNoteRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpsertExerciseNoteRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpsertExerciseNoteRequest> get serializer => _$UpsertExerciseNoteRequestSerializer();
}

class _$UpsertExerciseNoteRequestSerializer implements PrimitiveSerializer<UpsertExerciseNoteRequest> {
  @override
  final Iterable<Type> types = const [UpsertExerciseNoteRequest, _$UpsertExerciseNoteRequest];

  @override
  final String wireName = r'UpsertExerciseNoteRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpsertExerciseNoteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'workoutItemId';
    yield serializers.serialize(
      object.workoutItemId,
      specifiedType: const FullType(String),
    );
    yield r'exerciseId';
    yield serializers.serialize(
      object.exerciseId,
      specifiedType: const FullType(String),
    );
    if (object.loadKg != null) {
      yield r'loadKg';
      yield serializers.serialize(
        object.loadKg,
        specifiedType: const FullType.nullable(num),
      );
    }
    yield r'painFlag';
    yield serializers.serialize(
      object.painFlag,
      specifiedType: const FullType(bool),
    );
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
  }

  @override
  Object serialize(
    Serializers serializers,
    UpsertExerciseNoteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpsertExerciseNoteRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'workoutItemId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.workoutItemId = valueDes;
          break;
        case r'exerciseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
            specifiedType: const FullType(bool),
          ) as bool;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpsertExerciseNoteRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpsertExerciseNoteRequestBuilder();
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

