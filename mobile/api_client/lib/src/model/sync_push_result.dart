//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sync_push_result.g.dart';

/// SyncPushResult
///
/// Properties:
/// * [sessionsInserted] 
/// * [sessionsSkipped] 
@BuiltValue()
abstract class SyncPushResult implements Built<SyncPushResult, SyncPushResultBuilder> {
  @BuiltValueField(wireName: r'sessionsInserted')
  int? get sessionsInserted;

  @BuiltValueField(wireName: r'sessionsSkipped')
  int? get sessionsSkipped;

  SyncPushResult._();

  factory SyncPushResult([void updates(SyncPushResultBuilder b)]) = _$SyncPushResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SyncPushResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SyncPushResult> get serializer => _$SyncPushResultSerializer();
}

class _$SyncPushResultSerializer implements PrimitiveSerializer<SyncPushResult> {
  @override
  final Iterable<Type> types = const [SyncPushResult, _$SyncPushResult];

  @override
  final String wireName = r'SyncPushResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SyncPushResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.sessionsInserted != null) {
      yield r'sessionsInserted';
      yield serializers.serialize(
        object.sessionsInserted,
        specifiedType: const FullType(int),
      );
    }
    if (object.sessionsSkipped != null) {
      yield r'sessionsSkipped';
      yield serializers.serialize(
        object.sessionsSkipped,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SyncPushResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SyncPushResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sessionsInserted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sessionsInserted = valueDes;
          break;
        case r'sessionsSkipped':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sessionsSkipped = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SyncPushResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SyncPushResultBuilder();
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

