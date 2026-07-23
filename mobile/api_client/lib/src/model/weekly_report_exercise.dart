//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'weekly_report_exercise.g.dart';

/// WeeklyReportExercise
///
/// Properties:
/// * [exerciseId] 
/// * [timesPerformed] 
/// * [totalSets] 
/// * [totalReps] 
/// * [maxLoadKg] 
@BuiltValue()
abstract class WeeklyReportExercise implements Built<WeeklyReportExercise, WeeklyReportExerciseBuilder> {
  @BuiltValueField(wireName: r'exerciseId')
  String? get exerciseId;

  @BuiltValueField(wireName: r'timesPerformed')
  int? get timesPerformed;

  @BuiltValueField(wireName: r'totalSets')
  int? get totalSets;

  @BuiltValueField(wireName: r'totalReps')
  int? get totalReps;

  @BuiltValueField(wireName: r'maxLoadKg')
  num? get maxLoadKg;

  WeeklyReportExercise._();

  factory WeeklyReportExercise([void updates(WeeklyReportExerciseBuilder b)]) = _$WeeklyReportExercise;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WeeklyReportExerciseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WeeklyReportExercise> get serializer => _$WeeklyReportExerciseSerializer();
}

class _$WeeklyReportExerciseSerializer implements PrimitiveSerializer<WeeklyReportExercise> {
  @override
  final Iterable<Type> types = const [WeeklyReportExercise, _$WeeklyReportExercise];

  @override
  final String wireName = r'WeeklyReportExercise';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WeeklyReportExercise object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.exerciseId != null) {
      yield r'exerciseId';
      yield serializers.serialize(
        object.exerciseId,
        specifiedType: const FullType(String),
      );
    }
    if (object.timesPerformed != null) {
      yield r'timesPerformed';
      yield serializers.serialize(
        object.timesPerformed,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalSets != null) {
      yield r'totalSets';
      yield serializers.serialize(
        object.totalSets,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalReps != null) {
      yield r'totalReps';
      yield serializers.serialize(
        object.totalReps,
        specifiedType: const FullType(int),
      );
    }
    if (object.maxLoadKg != null) {
      yield r'maxLoadKg';
      yield serializers.serialize(
        object.maxLoadKg,
        specifiedType: const FullType.nullable(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WeeklyReportExercise object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WeeklyReportExerciseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'exerciseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.exerciseId = valueDes;
          break;
        case r'timesPerformed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.timesPerformed = valueDes;
          break;
        case r'totalSets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.totalSets = valueDes;
          break;
        case r'totalReps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.totalReps = valueDes;
          break;
        case r'maxLoadKg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.maxLoadKg = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WeeklyReportExercise deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WeeklyReportExerciseBuilder();
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

