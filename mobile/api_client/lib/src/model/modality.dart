//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'modality.g.dart';

/// Modality
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [colorHex] 
/// * [isIntervalBased] 
/// * [sortOrder] 
@BuiltValue()
abstract class Modality implements Built<Modality, ModalityBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'colorHex')
  String? get colorHex;

  @BuiltValueField(wireName: r'isIntervalBased')
  bool? get isIntervalBased;

  @BuiltValueField(wireName: r'sortOrder')
  int? get sortOrder;

  Modality._();

  factory Modality([void updates(ModalityBuilder b)]) = _$Modality;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ModalityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Modality> get serializer => _$ModalitySerializer();
}

class _$ModalitySerializer implements PrimitiveSerializer<Modality> {
  @override
  final Iterable<Type> types = const [Modality, _$Modality];

  @override
  final String wireName = r'Modality';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Modality object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.colorHex != null) {
      yield r'colorHex';
      yield serializers.serialize(
        object.colorHex,
        specifiedType: const FullType(String),
      );
    }
    if (object.isIntervalBased != null) {
      yield r'isIntervalBased';
      yield serializers.serialize(
        object.isIntervalBased,
        specifiedType: const FullType(bool),
      );
    }
    if (object.sortOrder != null) {
      yield r'sortOrder';
      yield serializers.serialize(
        object.sortOrder,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Modality object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ModalityBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'colorHex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.colorHex = valueDes;
          break;
        case r'isIntervalBased':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isIntervalBased = valueDes;
          break;
        case r'sortOrder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
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
  Modality deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ModalityBuilder();
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

