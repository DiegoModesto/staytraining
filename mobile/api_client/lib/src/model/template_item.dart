//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/workout_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'template_item.g.dart';

/// TemplateItem
///
/// Properties:
/// * [id] 
/// * [exerciseId] 
/// * [order] 
/// * [sectionLabel] 
/// * [sets] 
/// * [reps] 
/// * [restSeconds] 
/// * [durationSeconds] 
/// * [workSeconds] 
/// * [intervalRestSeconds] 
/// * [rounds] 
/// * [professorComment] 
@BuiltValue()
abstract class TemplateItem implements WorkoutItem, Built<TemplateItem, TemplateItemBuilder> {
  TemplateItem._();

  factory TemplateItem([void updates(TemplateItemBuilder b)]) = _$TemplateItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TemplateItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TemplateItem> get serializer => _$TemplateItemSerializer();
}

class _$TemplateItemSerializer implements PrimitiveSerializer<TemplateItem> {
  @override
  final Iterable<Type> types = const [TemplateItem, _$TemplateItem];

  @override
  final String wireName = r'TemplateItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TemplateItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.intervalRestSeconds != null) {
      yield r'intervalRestSeconds';
      yield serializers.serialize(
        object.intervalRestSeconds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.reps != null) {
      yield r'reps';
      yield serializers.serialize(
        object.reps,
        specifiedType: const FullType(int),
      );
    }
    if (object.exerciseId != null) {
      yield r'exerciseId';
      yield serializers.serialize(
        object.exerciseId,
        specifiedType: const FullType(String),
      );
    }
    if (object.sets != null) {
      yield r'sets';
      yield serializers.serialize(
        object.sets,
        specifiedType: const FullType(int),
      );
    }
    if (object.durationSeconds != null) {
      yield r'durationSeconds';
      yield serializers.serialize(
        object.durationSeconds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.restSeconds != null) {
      yield r'restSeconds';
      yield serializers.serialize(
        object.restSeconds,
        specifiedType: const FullType(int),
      );
    }
    if (object.professorComment != null) {
      yield r'professorComment';
      yield serializers.serialize(
        object.professorComment,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.workSeconds != null) {
      yield r'workSeconds';
      yield serializers.serialize(
        object.workSeconds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.sectionLabel != null) {
      yield r'sectionLabel';
      yield serializers.serialize(
        object.sectionLabel,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.rounds != null) {
      yield r'rounds';
      yield serializers.serialize(
        object.rounds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.order != null) {
      yield r'order';
      yield serializers.serialize(
        object.order,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TemplateItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TemplateItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'intervalRestSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.intervalRestSeconds = valueDes;
          break;
        case r'reps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reps = valueDes;
          break;
        case r'exerciseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.exerciseId = valueDes;
          break;
        case r'sets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sets = valueDes;
          break;
        case r'durationSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.durationSeconds = valueDes;
          break;
        case r'restSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.restSeconds = valueDes;
          break;
        case r'professorComment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.professorComment = valueDes;
          break;
        case r'workSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.workSeconds = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'sectionLabel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.sectionLabel = valueDes;
          break;
        case r'rounds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.rounds = valueDes;
          break;
        case r'order':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.order = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TemplateItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TemplateItemBuilder();
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

