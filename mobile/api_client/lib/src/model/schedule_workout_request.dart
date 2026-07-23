//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'schedule_workout_request.g.dart';

/// ScheduleWorkoutRequest
///
/// Properties:
/// * [workoutId] 
/// * [date] 
@BuiltValue()
abstract class ScheduleWorkoutRequest implements Built<ScheduleWorkoutRequest, ScheduleWorkoutRequestBuilder> {
  @BuiltValueField(wireName: r'workoutId')
  String get workoutId;

  @BuiltValueField(wireName: r'date')
  Date get date;

  ScheduleWorkoutRequest._();

  factory ScheduleWorkoutRequest([void updates(ScheduleWorkoutRequestBuilder b)]) = _$ScheduleWorkoutRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScheduleWorkoutRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScheduleWorkoutRequest> get serializer => _$ScheduleWorkoutRequestSerializer();
}

class _$ScheduleWorkoutRequestSerializer implements PrimitiveSerializer<ScheduleWorkoutRequest> {
  @override
  final Iterable<Type> types = const [ScheduleWorkoutRequest, _$ScheduleWorkoutRequest];

  @override
  final String wireName = r'ScheduleWorkoutRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScheduleWorkoutRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'workoutId';
    yield serializers.serialize(
      object.workoutId,
      specifiedType: const FullType(String),
    );
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(Date),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ScheduleWorkoutRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScheduleWorkoutRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'workoutId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.workoutId = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.date = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScheduleWorkoutRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScheduleWorkoutRequestBuilder();
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

