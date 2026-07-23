//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'profile_apportment.g.dart';

/// ProfileApportment
///
/// Properties:
/// * [id] 
/// * [bodyPartName] 
/// * [problemTypeName] 
/// * [observation] 
@BuiltValue()
abstract class ProfileApportment implements Built<ProfileApportment, ProfileApportmentBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'bodyPartName')
  String? get bodyPartName;

  @BuiltValueField(wireName: r'problemTypeName')
  String? get problemTypeName;

  @BuiltValueField(wireName: r'observation')
  String? get observation;

  ProfileApportment._();

  factory ProfileApportment([void updates(ProfileApportmentBuilder b)]) = _$ProfileApportment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProfileApportmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProfileApportment> get serializer => _$ProfileApportmentSerializer();
}

class _$ProfileApportmentSerializer implements PrimitiveSerializer<ProfileApportment> {
  @override
  final Iterable<Type> types = const [ProfileApportment, _$ProfileApportment];

  @override
  final String wireName = r'ProfileApportment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProfileApportment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.bodyPartName != null) {
      yield r'bodyPartName';
      yield serializers.serialize(
        object.bodyPartName,
        specifiedType: const FullType(String),
      );
    }
    if (object.problemTypeName != null) {
      yield r'problemTypeName';
      yield serializers.serialize(
        object.problemTypeName,
        specifiedType: const FullType(String),
      );
    }
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
    ProfileApportment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProfileApportmentBuilder result,
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
        case r'bodyPartName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bodyPartName = valueDes;
          break;
        case r'problemTypeName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.problemTypeName = valueDes;
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
  ProfileApportment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProfileApportmentBuilder();
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

