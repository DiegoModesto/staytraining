//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'name_request.g.dart';

/// NameRequest
///
/// Properties:
/// * [name] 
@BuiltValue()
abstract class NameRequest implements Built<NameRequest, NameRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  NameRequest._();

  factory NameRequest([void updates(NameRequestBuilder b)]) = _$NameRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NameRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NameRequest> get serializer => _$NameRequestSerializer();
}

class _$NameRequestSerializer implements PrimitiveSerializer<NameRequest> {
  @override
  final Iterable<Type> types = const [NameRequest, _$NameRequest];

  @override
  final String wireName = r'NameRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NameRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NameRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NameRequestBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NameRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NameRequestBuilder();
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

