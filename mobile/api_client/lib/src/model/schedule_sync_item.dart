//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'schedule_sync_item.g.dart';

/// ScheduleSyncItem
///
/// Properties:
/// * [id] 
/// * [date] 
/// * [workoutId] 
@BuiltValue()
abstract class ScheduleSyncItem implements Built<ScheduleSyncItem, ScheduleSyncItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'date')
  Date? get date;

  @BuiltValueField(wireName: r'workoutId')
  String? get workoutId;

  ScheduleSyncItem._();

  factory ScheduleSyncItem([void updates(ScheduleSyncItemBuilder b)]) = _$ScheduleSyncItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScheduleSyncItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScheduleSyncItem> get serializer => _$ScheduleSyncItemSerializer();
}

class _$ScheduleSyncItemSerializer implements PrimitiveSerializer<ScheduleSyncItem> {
  @override
  final Iterable<Type> types = const [ScheduleSyncItem, _$ScheduleSyncItem];

  @override
  final String wireName = r'ScheduleSyncItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScheduleSyncItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ScheduleSyncItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScheduleSyncItemBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScheduleSyncItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScheduleSyncItemBuilder();
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

