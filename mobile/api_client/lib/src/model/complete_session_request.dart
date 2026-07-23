//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'complete_session_request.g.dart';

/// CompleteSessionRequest
///
/// Properties:
/// * [completionRating] 
/// * [overallComment] 
@BuiltValue()
abstract class CompleteSessionRequest implements Built<CompleteSessionRequest, CompleteSessionRequestBuilder> {
  @BuiltValueField(wireName: r'completionRating')
  int? get completionRating;

  @BuiltValueField(wireName: r'overallComment')
  String? get overallComment;

  CompleteSessionRequest._();

  factory CompleteSessionRequest([void updates(CompleteSessionRequestBuilder b)]) = _$CompleteSessionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CompleteSessionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CompleteSessionRequest> get serializer => _$CompleteSessionRequestSerializer();
}

class _$CompleteSessionRequestSerializer implements PrimitiveSerializer<CompleteSessionRequest> {
  @override
  final Iterable<Type> types = const [CompleteSessionRequest, _$CompleteSessionRequest];

  @override
  final String wireName = r'CompleteSessionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CompleteSessionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CompleteSessionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CompleteSessionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CompleteSessionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CompleteSessionRequestBuilder();
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

