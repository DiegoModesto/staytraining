//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upload_my_profile_photo200_response.g.dart';

/// UploadMyProfilePhoto200Response
///
/// Properties:
/// * [key] 
/// * [photoUrl] 
@BuiltValue()
abstract class UploadMyProfilePhoto200Response implements Built<UploadMyProfilePhoto200Response, UploadMyProfilePhoto200ResponseBuilder> {
  @BuiltValueField(wireName: r'key')
  String? get key;

  @BuiltValueField(wireName: r'photoUrl')
  String? get photoUrl;

  UploadMyProfilePhoto200Response._();

  factory UploadMyProfilePhoto200Response([void updates(UploadMyProfilePhoto200ResponseBuilder b)]) = _$UploadMyProfilePhoto200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UploadMyProfilePhoto200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UploadMyProfilePhoto200Response> get serializer => _$UploadMyProfilePhoto200ResponseSerializer();
}

class _$UploadMyProfilePhoto200ResponseSerializer implements PrimitiveSerializer<UploadMyProfilePhoto200Response> {
  @override
  final Iterable<Type> types = const [UploadMyProfilePhoto200Response, _$UploadMyProfilePhoto200Response];

  @override
  final String wireName = r'UploadMyProfilePhoto200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UploadMyProfilePhoto200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.key != null) {
      yield r'key';
      yield serializers.serialize(
        object.key,
        specifiedType: const FullType(String),
      );
    }
    if (object.photoUrl != null) {
      yield r'photoUrl';
      yield serializers.serialize(
        object.photoUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UploadMyProfilePhoto200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UploadMyProfilePhoto200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.key = valueDes;
          break;
        case r'photoUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.photoUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UploadMyProfilePhoto200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UploadMyProfilePhoto200ResponseBuilder();
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

