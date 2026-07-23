//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/exercise_media_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'exercise_media_input.g.dart';

/// ExerciseMediaInput
///
/// Properties:
/// * [kind] 
/// * [storageKey] 
/// * [url] 
/// * [contentType] 
/// * [sizeBytes] 
@BuiltValue()
abstract class ExerciseMediaInput implements Built<ExerciseMediaInput, ExerciseMediaInputBuilder> {
  @BuiltValueField(wireName: r'kind')
  ExerciseMediaKind? get kind;
  // enum kindEnum {  0,  1,  2,  3,  };

  @BuiltValueField(wireName: r'storageKey')
  String? get storageKey;

  @BuiltValueField(wireName: r'url')
  String? get url;

  @BuiltValueField(wireName: r'contentType')
  String? get contentType;

  @BuiltValueField(wireName: r'sizeBytes')
  int? get sizeBytes;

  ExerciseMediaInput._();

  factory ExerciseMediaInput([void updates(ExerciseMediaInputBuilder b)]) = _$ExerciseMediaInput;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExerciseMediaInputBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExerciseMediaInput> get serializer => _$ExerciseMediaInputSerializer();
}

class _$ExerciseMediaInputSerializer implements PrimitiveSerializer<ExerciseMediaInput> {
  @override
  final Iterable<Type> types = const [ExerciseMediaInput, _$ExerciseMediaInput];

  @override
  final String wireName = r'ExerciseMediaInput';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExerciseMediaInput object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(ExerciseMediaKind),
      );
    }
    if (object.storageKey != null) {
      yield r'storageKey';
      yield serializers.serialize(
        object.storageKey,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.url != null) {
      yield r'url';
      yield serializers.serialize(
        object.url,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.contentType != null) {
      yield r'contentType';
      yield serializers.serialize(
        object.contentType,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.sizeBytes != null) {
      yield r'sizeBytes';
      yield serializers.serialize(
        object.sizeBytes,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExerciseMediaInput object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExerciseMediaInputBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ExerciseMediaKind),
          ) as ExerciseMediaKind?;
          if (valueDes == null) continue;
          result.kind = valueDes;
          break;
        case r'storageKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.storageKey = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.url = valueDes;
          break;
        case r'contentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contentType = valueDes;
          break;
        case r'sizeBytes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sizeBytes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExerciseMediaInput deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExerciseMediaInputBuilder();
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

