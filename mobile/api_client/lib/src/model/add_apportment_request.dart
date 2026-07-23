//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_apportment_request.g.dart';

/// AddApportmentRequest
///
/// Properties:
/// * [bodyPartId] 
/// * [problemTypeId] 
/// * [observation] 
@BuiltValue()
abstract class AddApportmentRequest implements Built<AddApportmentRequest, AddApportmentRequestBuilder> {
  @BuiltValueField(wireName: r'bodyPartId')
  String get bodyPartId;

  @BuiltValueField(wireName: r'problemTypeId')
  String get problemTypeId;

  @BuiltValueField(wireName: r'observation')
  String? get observation;

  AddApportmentRequest._();

  factory AddApportmentRequest([void updates(AddApportmentRequestBuilder b)]) = _$AddApportmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddApportmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddApportmentRequest> get serializer => _$AddApportmentRequestSerializer();
}

class _$AddApportmentRequestSerializer implements PrimitiveSerializer<AddApportmentRequest> {
  @override
  final Iterable<Type> types = const [AddApportmentRequest, _$AddApportmentRequest];

  @override
  final String wireName = r'AddApportmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddApportmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'bodyPartId';
    yield serializers.serialize(
      object.bodyPartId,
      specifiedType: const FullType(String),
    );
    yield r'problemTypeId';
    yield serializers.serialize(
      object.problemTypeId,
      specifiedType: const FullType(String),
    );
    if (object.observation != null) {
      yield r'observation';
      yield serializers.serialize(
        object.observation,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AddApportmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AddApportmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'bodyPartId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.bodyPartId = valueDes;
          break;
        case r'problemTypeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.problemTypeId = valueDes;
          break;
        case r'observation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.observation = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddApportmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddApportmentRequestBuilder();
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

