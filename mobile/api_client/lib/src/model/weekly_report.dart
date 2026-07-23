//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/date.dart';
import 'package:built_collection/built_collection.dart';
import 'package:staytraining_api/src/model/weekly_report_exercise.dart';
import 'package:staytraining_api/src/model/weekly_report_session.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'weekly_report.g.dart';

/// WeeklyReport
///
/// Properties:
/// * [weekStart] 
/// * [weekEnd] 
/// * [sessionCount] 
/// * [completedSessionCount] 
/// * [averageRating] 
/// * [distinctWorkoutCount] 
/// * [sessions] 
/// * [exercises] 
@BuiltValue()
abstract class WeeklyReport implements Built<WeeklyReport, WeeklyReportBuilder> {
  @BuiltValueField(wireName: r'weekStart')
  Date? get weekStart;

  @BuiltValueField(wireName: r'weekEnd')
  Date? get weekEnd;

  @BuiltValueField(wireName: r'sessionCount')
  int? get sessionCount;

  @BuiltValueField(wireName: r'completedSessionCount')
  int? get completedSessionCount;

  @BuiltValueField(wireName: r'averageRating')
  num? get averageRating;

  @BuiltValueField(wireName: r'distinctWorkoutCount')
  int? get distinctWorkoutCount;

  @BuiltValueField(wireName: r'sessions')
  BuiltList<WeeklyReportSession>? get sessions;

  @BuiltValueField(wireName: r'exercises')
  BuiltList<WeeklyReportExercise>? get exercises;

  WeeklyReport._();

  factory WeeklyReport([void updates(WeeklyReportBuilder b)]) = _$WeeklyReport;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WeeklyReportBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WeeklyReport> get serializer => _$WeeklyReportSerializer();
}

class _$WeeklyReportSerializer implements PrimitiveSerializer<WeeklyReport> {
  @override
  final Iterable<Type> types = const [WeeklyReport, _$WeeklyReport];

  @override
  final String wireName = r'WeeklyReport';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WeeklyReport object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.weekStart != null) {
      yield r'weekStart';
      yield serializers.serialize(
        object.weekStart,
        specifiedType: const FullType(Date),
      );
    }
    if (object.weekEnd != null) {
      yield r'weekEnd';
      yield serializers.serialize(
        object.weekEnd,
        specifiedType: const FullType(Date),
      );
    }
    if (object.sessionCount != null) {
      yield r'sessionCount';
      yield serializers.serialize(
        object.sessionCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.completedSessionCount != null) {
      yield r'completedSessionCount';
      yield serializers.serialize(
        object.completedSessionCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.averageRating != null) {
      yield r'averageRating';
      yield serializers.serialize(
        object.averageRating,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.distinctWorkoutCount != null) {
      yield r'distinctWorkoutCount';
      yield serializers.serialize(
        object.distinctWorkoutCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.sessions != null) {
      yield r'sessions';
      yield serializers.serialize(
        object.sessions,
        specifiedType: const FullType(BuiltList, [FullType(WeeklyReportSession)]),
      );
    }
    if (object.exercises != null) {
      yield r'exercises';
      yield serializers.serialize(
        object.exercises,
        specifiedType: const FullType(BuiltList, [FullType(WeeklyReportExercise)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WeeklyReport object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WeeklyReportBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'weekStart':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.weekStart = valueDes;
          break;
        case r'weekEnd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.weekEnd = valueDes;
          break;
        case r'sessionCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sessionCount = valueDes;
          break;
        case r'completedSessionCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.completedSessionCount = valueDes;
          break;
        case r'averageRating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.averageRating = valueDes;
          break;
        case r'distinctWorkoutCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.distinctWorkoutCount = valueDes;
          break;
        case r'sessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(WeeklyReportSession)]),
          ) as BuiltList<WeeklyReportSession>?;
          if (valueDes == null) continue;
          result.sessions.replace(valueDes);
          break;
        case r'exercises':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(WeeklyReportExercise)]),
          ) as BuiltList<WeeklyReportExercise>?;
          if (valueDes == null) continue;
          result.exercises.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WeeklyReport deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WeeklyReportBuilder();
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

