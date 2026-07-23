//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'week_schedule_item.g.dart';

/// WeekScheduleItem
///
/// Properties:
/// * [scheduleId] 
/// * [date] 
/// * [workoutId] 
/// * [workoutName] 
@BuiltValue()
abstract class WeekScheduleItem implements Built<WeekScheduleItem, WeekScheduleItemBuilder> {
  @BuiltValueField(wireName: r'scheduleId')
  String? get scheduleId;

  @BuiltValueField(wireName: r'date')
  Date? get date;

  @BuiltValueField(wireName: r'workoutId')
  String? get workoutId;

  @BuiltValueField(wireName: r'workoutName')
  String? get workoutName;

  WeekScheduleItem._();

  factory WeekScheduleItem([void updates(WeekScheduleItemBuilder b)]) = _$WeekScheduleItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WeekScheduleItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WeekScheduleItem> get serializer => _$WeekScheduleItemSerializer();
}

class _$WeekScheduleItemSerializer implements PrimitiveSerializer<WeekScheduleItem> {
  @override
  final Iterable<Type> types = const [WeekScheduleItem, _$WeekScheduleItem];

  @override
  final String wireName = r'WeekScheduleItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WeekScheduleItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.scheduleId != null) {
      yield r'scheduleId';
      yield serializers.serialize(
        object.scheduleId,
        specifiedType: const FullType(String),
      );
    }
    if (object.date != null) {
      yield r'date';
      yield serializers.serialize(
        object.date,
        specifiedType: const FullType(Date),
      );
    }
    if (object.workoutId != null) {
      yield r'workoutId';
      yield serializers.serialize(
        object.workoutId,
        specifiedType: const FullType(String),
      );
    }
    if (object.workoutName != null) {
      yield r'workoutName';
      yield serializers.serialize(
        object.workoutName,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WeekScheduleItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WeekScheduleItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'scheduleId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.scheduleId = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.date = valueDes;
          break;
        case r'workoutId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.workoutId = valueDes;
          break;
        case r'workoutName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.workoutName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WeekScheduleItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WeekScheduleItemBuilder();
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

