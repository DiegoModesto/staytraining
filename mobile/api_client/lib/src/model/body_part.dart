//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/problem_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_part.g.dart';

/// BodyPart
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [sortOrder] 
/// * [problemTypes] 
@BuiltValue()
abstract class BodyPart implements Built<BodyPart, BodyPartBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'sortOrder')
  int? get sortOrder;

  @BuiltValueField(wireName: r'problemTypes')
  BuiltList<ProblemType>? get problemTypes;

  BodyPart._();

  factory BodyPart([void updates(BodyPartBuilder b)]) = _$BodyPart;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyPartBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyPart> get serializer => _$BodyPartSerializer();
}

class _$BodyPartSerializer implements PrimitiveSerializer<BodyPart> {
  @override
  final Iterable<Type> types = const [BodyPart, _$BodyPart];

  @override
  final String wireName = r'BodyPart';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyPart object, {
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
    if (object.sortOrder != null) {
      yield r'sortOrder';
      yield serializers.serialize(
        object.sortOrder,
        specifiedType: const FullType(int),
      );
    }
    if (object.problemTypes != null) {
      yield r'problemTypes';
      yield serializers.serialize(
        object.problemTypes,
        specifiedType: const FullType(BuiltList, [FullType(ProblemType)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyPart object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyPartBuilder result,
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
        case r'sortOrder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sortOrder = valueDes;
          break;
        case r'problemTypes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(ProblemType)]),
          ) as BuiltList<ProblemType>?;
          if (valueDes == null) continue;
          result.problemTypes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyPart deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyPartBuilder();
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

