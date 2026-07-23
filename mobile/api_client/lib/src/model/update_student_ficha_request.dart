//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:staytraining_api/src/model/blood_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_student_ficha_request.g.dart';

/// UpdateStudentFichaRequest
///
/// Properties:
/// * [fullName] 
/// * [email] 
/// * [phone] 
/// * [emergencyPhone] 
/// * [bloodType] 
/// * [heightCm] 
/// * [weightKg] 
/// * [goals] 
@BuiltValue()
abstract class UpdateStudentFichaRequest implements Built<UpdateStudentFichaRequest, UpdateStudentFichaRequestBuilder> {
  @BuiltValueField(wireName: r'fullName')
  String get fullName;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  @BuiltValueField(wireName: r'emergencyPhone')
  String? get emergencyPhone;

  @BuiltValueField(wireName: r'bloodType')
  BloodType get bloodType;
  // enum bloodTypeEnum {  0,  1,  2,  3,  4,  5,  6,  7,  8,  };

  @BuiltValueField(wireName: r'heightCm')
  int? get heightCm;

  @BuiltValueField(wireName: r'weightKg')
  num? get weightKg;

  @BuiltValueField(wireName: r'goals')
  String? get goals;

  UpdateStudentFichaRequest._();

  factory UpdateStudentFichaRequest([void updates(UpdateStudentFichaRequestBuilder b)]) = _$UpdateStudentFichaRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateStudentFichaRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateStudentFichaRequest> get serializer => _$UpdateStudentFichaRequestSerializer();
}

class _$UpdateStudentFichaRequestSerializer implements PrimitiveSerializer<UpdateStudentFichaRequest> {
  @override
  final Iterable<Type> types = const [UpdateStudentFichaRequest, _$UpdateStudentFichaRequest];

  @override
  final String wireName = r'UpdateStudentFichaRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateStudentFichaRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'fullName';
    yield serializers.serialize(
      object.fullName,
      specifiedType: const FullType(String),
    );
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
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
    yield r'bloodType';
    yield serializers.serialize(
      object.bloodType,
      specifiedType: const FullType(BloodType),
    );
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
    if (object.goals != null) {
      yield r'goals';
      yield serializers.serialize(
        object.goals,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateStudentFichaRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateStudentFichaRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fullName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
            specifiedType: const FullType(BloodType),
          ) as BloodType;
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
        case r'goals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.goals = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateStudentFichaRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateStudentFichaRequestBuilder();
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

