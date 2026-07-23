//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reorder_workout_items_request.g.dart';

/// ReorderWorkoutItemsRequest
///
/// Properties:
/// * [orderedItemIds] 
@BuiltValue()
abstract class ReorderWorkoutItemsRequest implements Built<ReorderWorkoutItemsRequest, ReorderWorkoutItemsRequestBuilder> {
  @BuiltValueField(wireName: r'orderedItemIds')
  BuiltList<String> get orderedItemIds;

  ReorderWorkoutItemsRequest._();

  factory ReorderWorkoutItemsRequest([void updates(ReorderWorkoutItemsRequestBuilder b)]) = _$ReorderWorkoutItemsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReorderWorkoutItemsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReorderWorkoutItemsRequest> get serializer => _$ReorderWorkoutItemsRequestSerializer();
}

class _$ReorderWorkoutItemsRequestSerializer implements PrimitiveSerializer<ReorderWorkoutItemsRequest> {
  @override
  final Iterable<Type> types = const [ReorderWorkoutItemsRequest, _$ReorderWorkoutItemsRequest];

  @override
  final String wireName = r'ReorderWorkoutItemsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReorderWorkoutItemsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'orderedItemIds';
    yield serializers.serialize(
      object.orderedItemIds,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReorderWorkoutItemsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReorderWorkoutItemsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'orderedItemIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.orderedItemIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReorderWorkoutItemsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReorderWorkoutItemsRequestBuilder();
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

