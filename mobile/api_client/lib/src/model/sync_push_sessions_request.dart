//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/session_push_input.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sync_push_sessions_request.g.dart';

/// SyncPushSessionsRequest
///
/// Properties:
/// * [sessions] 
@BuiltValue()
abstract class SyncPushSessionsRequest implements Built<SyncPushSessionsRequest, SyncPushSessionsRequestBuilder> {
  @BuiltValueField(wireName: r'sessions')
  BuiltList<SessionPushInput>? get sessions;

  SyncPushSessionsRequest._();

  factory SyncPushSessionsRequest([void updates(SyncPushSessionsRequestBuilder b)]) = _$SyncPushSessionsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SyncPushSessionsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SyncPushSessionsRequest> get serializer => _$SyncPushSessionsRequestSerializer();
}

class _$SyncPushSessionsRequestSerializer implements PrimitiveSerializer<SyncPushSessionsRequest> {
  @override
  final Iterable<Type> types = const [SyncPushSessionsRequest, _$SyncPushSessionsRequest];

  @override
  final String wireName = r'SyncPushSessionsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SyncPushSessionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.sessions != null) {
      yield r'sessions';
      yield serializers.serialize(
        object.sessions,
        specifiedType: const FullType(BuiltList, [FullType(SessionPushInput)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SyncPushSessionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SyncPushSessionsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SessionPushInput)]),
          ) as BuiltList<SessionPushInput>?;
          if (valueDes == null) continue;
          result.sessions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SyncPushSessionsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SyncPushSessionsRequestBuilder();
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

