//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workout_template_list_item.g.dart';

/// WorkoutTemplateListItem
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [modalityId] 
/// * [modalityName] 
/// * [isSystemDefault] 
/// * [itemCount] 
@BuiltValue()
abstract class WorkoutTemplateListItem implements Built<WorkoutTemplateListItem, WorkoutTemplateListItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'modalityId')
  String? get modalityId;

  @BuiltValueField(wireName: r'modalityName')
  String? get modalityName;

  @BuiltValueField(wireName: r'isSystemDefault')
  bool? get isSystemDefault;

  @BuiltValueField(wireName: r'itemCount')
  int? get itemCount;

  WorkoutTemplateListItem._();

  factory WorkoutTemplateListItem([void updates(WorkoutTemplateListItemBuilder b)]) = _$WorkoutTemplateListItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkoutTemplateListItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkoutTemplateListItem> get serializer => _$WorkoutTemplateListItemSerializer();
}

class _$WorkoutTemplateListItemSerializer implements PrimitiveSerializer<WorkoutTemplateListItem> {
  @override
  final Iterable<Type> types = const [WorkoutTemplateListItem, _$WorkoutTemplateListItem];

  @override
  final String wireName = r'WorkoutTemplateListItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkoutTemplateListItem object, {
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
    if (object.modalityId != null) {
      yield r'modalityId';
      yield serializers.serialize(
        object.modalityId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.modalityName != null) {
      yield r'modalityName';
      yield serializers.serialize(
        object.modalityName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.isSystemDefault != null) {
      yield r'isSystemDefault';
      yield serializers.serialize(
        object.isSystemDefault,
        specifiedType: const FullType(bool),
      );
    }
    if (object.itemCount != null) {
      yield r'itemCount';
      yield serializers.serialize(
        object.itemCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkoutTemplateListItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WorkoutTemplateListItemBuilder result,
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
        case r'modalityId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.modalityId = valueDes;
          break;
        case r'modalityName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.modalityName = valueDes;
          break;
        case r'isSystemDefault':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isSystemDefault = valueDes;
          break;
        case r'itemCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.itemCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkoutTemplateListItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkoutTemplateListItemBuilder();
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

