//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'modality_request.g.dart';

/// ModalityRequest
///
/// Properties:
/// * [name] 
/// * [colorHex] - hex #rrggbb
/// * [isIntervalBased] 
/// * [sortOrder] 
@BuiltValue()
abstract class ModalityRequest implements Built<ModalityRequest, ModalityRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  /// hex #rrggbb
  @BuiltValueField(wireName: r'colorHex')
  String get colorHex;

  @BuiltValueField(wireName: r'isIntervalBased')
  bool get isIntervalBased;

  @BuiltValueField(wireName: r'sortOrder')
  int get sortOrder;

  ModalityRequest._();

  factory ModalityRequest([void updates(ModalityRequestBuilder b)]) = _$ModalityRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ModalityRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ModalityRequest> get serializer => _$ModalityRequestSerializer();
}

class _$ModalityRequestSerializer implements PrimitiveSerializer<ModalityRequest> {
  @override
  final Iterable<Type> types = const [ModalityRequest, _$ModalityRequest];

  @override
  final String wireName = r'ModalityRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ModalityRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'colorHex';
    yield serializers.serialize(
      object.colorHex,
      specifiedType: const FullType(String),
    );
    yield r'isIntervalBased';
    yield serializers.serialize(
      object.isIntervalBased,
      specifiedType: const FullType(bool),
    );
    yield r'sortOrder';
    yield serializers.serialize(
      object.sortOrder,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ModalityRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ModalityRequestBuilder result,
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
        case r'colorHex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.colorHex = valueDes;
          break;
        case r'isIntervalBased':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isIntervalBased = valueDes;
          break;
        case r'sortOrder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sortOrder = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ModalityRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ModalityRequestBuilder();
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

