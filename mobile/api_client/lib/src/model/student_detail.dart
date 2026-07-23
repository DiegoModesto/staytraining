//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/date.dart';
import 'package:staytraining_api/src/model/blood_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:staytraining_api/src/model/health_apportment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_detail.g.dart';

/// StudentDetail
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [fullName] 
/// * [email] 
/// * [birthDate] 
/// * [goals] 
/// * [phone] 
/// * [emergencyPhone] 
/// * [bloodType] 
/// * [heightCm] 
/// * [weightKg] 
/// * [photoUrl] 
/// * [healthApportments] 
@BuiltValue()
abstract class StudentDetail implements Built<StudentDetail, StudentDetailBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'fullName')
  String? get fullName;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'birthDate')
  Date? get birthDate;

  @BuiltValueField(wireName: r'goals')
  String? get goals;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  @BuiltValueField(wireName: r'emergencyPhone')
  String? get emergencyPhone;

  @BuiltValueField(wireName: r'bloodType')
  BloodType? get bloodType;
  // enum bloodTypeEnum {  0,  1,  2,  3,  4,  5,  6,  7,  8,  };

  @BuiltValueField(wireName: r'heightCm')
  int? get heightCm;

  @BuiltValueField(wireName: r'weightKg')
  num? get weightKg;

  @BuiltValueField(wireName: r'photoUrl')
  String? get photoUrl;

  @BuiltValueField(wireName: r'healthApportments')
  BuiltList<HealthApportment>? get healthApportments;

  StudentDetail._();

  factory StudentDetail([void updates(StudentDetailBuilder b)]) = _$StudentDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentDetail> get serializer => _$StudentDetailSerializer();
}

class _$StudentDetailSerializer implements PrimitiveSerializer<StudentDetail> {
  @override
  final Iterable<Type> types = const [StudentDetail, _$StudentDetail];

  @override
  final String wireName = r'StudentDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.fullName != null) {
      yield r'fullName';
      yield serializers.serialize(
        object.fullName,
        specifiedType: const FullType(String),
      );
    }
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.birthDate != null) {
      yield r'birthDate';
      yield serializers.serialize(
        object.birthDate,
        specifiedType: const FullType.nullable(Date),
      );
    }
    if (object.goals != null) {
      yield r'goals';
      yield serializers.serialize(
        object.goals,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.phone != null) {
      yield r'phone';
      yield serializers.serialize(
        object.phone,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.emergencyPhone != null) {
      yield r'emergencyPhone';
      yield serializers.serialize(
        object.emergencyPhone,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.bloodType != null) {
      yield r'bloodType';
      yield serializers.serialize(
        object.bloodType,
        specifiedType: const FullType(BloodType),
      );
    }
    if (object.heightCm != null) {
      yield r'heightCm';
      yield serializers.serialize(
        object.heightCm,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.weightKg != null) {
      yield r'weightKg';
      yield serializers.serialize(
        object.weightKg,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.photoUrl != null) {
      yield r'photoUrl';
      yield serializers.serialize(
        object.photoUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.healthApportments != null) {
      yield r'healthApportments';
      yield serializers.serialize(
        object.healthApportments,
        specifiedType: const FullType(BuiltList, [FullType(HealthApportment)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StudentDetailBuilder result,
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
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userId = valueDes;
          break;
        case r'fullName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fullName = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'birthDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.birthDate = valueDes;
          break;
        case r'goals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.goals = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.phone = valueDes;
          break;
        case r'emergencyPhone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.emergencyPhone = valueDes;
          break;
        case r'bloodType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BloodType),
          ) as BloodType?;
          if (valueDes == null) continue;
          result.bloodType = valueDes;
          break;
        case r'heightCm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.heightCm = valueDes;
          break;
        case r'weightKg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.weightKg = valueDes;
          break;
        case r'photoUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.photoUrl = valueDes;
          break;
        case r'healthApportments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(HealthApportment)]),
          ) as BuiltList<HealthApportment>?;
          if (valueDes == null) continue;
          result.healthApportments.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StudentDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentDetailBuilder();
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

