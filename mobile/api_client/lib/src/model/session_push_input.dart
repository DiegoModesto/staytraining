//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:staytraining_api/src/model/note_push_input.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session_push_input.g.dart';

/// SessionPushInput
///
/// Properties:
/// * [id] 
/// * [workoutId] 
/// * [startedAt] 
/// * [completedAt] 
/// * [completionRating] 
/// * [overallComment] 
/// * [notes] 
@BuiltValue()
abstract class SessionPushInput implements Built<SessionPushInput, SessionPushInputBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'workoutId')
  String? get workoutId;

  @BuiltValueField(wireName: r'startedAt')
  DateTime? get startedAt;

  @BuiltValueField(wireName: r'completedAt')
  DateTime? get completedAt;

  @BuiltValueField(wireName: r'completionRating')
  int? get completionRating;

  @BuiltValueField(wireName: r'overallComment')
  String? get overallComment;

  @BuiltValueField(wireName: r'notes')
  BuiltList<NotePushInput>? get notes;

  SessionPushInput._();

  factory SessionPushInput([void updates(SessionPushInputBuilder b)]) = _$SessionPushInput;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SessionPushInputBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SessionPushInput> get serializer => _$SessionPushInputSerializer();
}

class _$SessionPushInputSerializer implements PrimitiveSerializer<SessionPushInput> {
  @override
  final Iterable<Type> types = const [SessionPushInput, _$SessionPushInput];

  @override
  final String wireName = r'SessionPushInput';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SessionPushInput object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.workoutId != null) {
      yield r'workoutId';
      yield serializers.serialize(
        object.workoutId,
        specifiedType: const FullType(String),
      );
    }
    if (object.startedAt != null) {
      yield r'startedAt';
      yield serializers.serialize(
        object.startedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.completedAt != null) {
      yield r'completedAt';
      yield serializers.serialize(
        object.completedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.completionRating != null) {
      yield r'completionRating';
      yield serializers.serialize(
        object.completionRating,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.overallComment != null) {
      yield r'overallComment';
      yield serializers.serialize(
        object.overallComment,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType(BuiltList, [FullType(NotePushInput)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SessionPushInput object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SessionPushInputBuilder result,
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
        case r'workoutId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.workoutId = valueDes;
          break;
        case r'startedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.startedAt = valueDes;
          break;
        case r'completedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.completedAt = valueDes;
          break;
        case r'completionRating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.completionRating = valueDes;
          break;
        case r'overallComment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.overallComment = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(NotePushInput)]),
          ) as BuiltList<NotePushInput>?;
          if (valueDes == null) continue;
          result.notes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SessionPushInput deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SessionPushInputBuilder();
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

