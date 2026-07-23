//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upload_exercise_media201_response.g.dart';

/// UploadExerciseMedia201Response
///
/// Properties:
/// * [id] 
/// * [key] 
@BuiltValue()
abstract class UploadExerciseMedia201Response implements Built<UploadExerciseMedia201Response, UploadExerciseMedia201ResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'key')
  String? get key;

  UploadExerciseMedia201Response._();

  factory UploadExerciseMedia201Response([void updates(UploadExerciseMedia201ResponseBuilder b)]) = _$UploadExerciseMedia201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UploadExerciseMedia201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UploadExerciseMedia201Response> get serializer => _$UploadExerciseMedia201ResponseSerializer();
}

class _$UploadExerciseMedia201ResponseSerializer implements PrimitiveSerializer<UploadExerciseMedia201Response> {
  @override
  final Iterable<Type> types = const [UploadExerciseMedia201Response, _$UploadExerciseMedia201Response];

  @override
  final String wireName = r'UploadExerciseMedia201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UploadExerciseMedia201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.key != null) {
      yield r'key';
      yield serializers.serialize(
        object.key,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UploadExerciseMedia201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UploadExerciseMedia201ResponseBuilder result,
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
        case r'key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.key = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UploadExerciseMedia201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UploadExerciseMedia201ResponseBuilder();
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

