// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (Serializers().toBuilder()
      ..add($WorkoutItem.serializer)
      ..add(AddApportmentRequest.serializer)
      ..add(AddExerciseYoutubeMediaRequest.serializer)
      ..add(AddStudentNoteRequest.serializer)
      ..add(BloodType.serializer)
      ..add(BodyPart.serializer)
      ..add(CompleteSessionRequest.serializer)
      ..add(CreateExerciseRequest.serializer)
      ..add(CreateProblemTypeRequest.serializer)
      ..add(CreateWorkoutFromTemplateRequest.serializer)
      ..add(CreateWorkoutRequest.serializer)
      ..add(CreateWorkoutTemplateRequest.serializer)
      ..add(DevicePlatform.serializer)
      ..add(Exercise.serializer)
      ..add(ExerciseListItem.serializer)
      ..add(ExerciseMedia.serializer)
      ..add(ExerciseMediaInput.serializer)
      ..add(ExerciseMediaKind.serializer)
      ..add(ExerciseNote.serializer)
      ..add(HealthApportment.serializer)
      ..add(IdResponse.serializer)
      ..add(Modality.serializer)
      ..add(ModalityRequest.serializer)
      ..add(MuscleGroup.serializer)
      ..add(MuscleGroupRequest.serializer)
      ..add(NameRequest.serializer)
      ..add(NotePushInput.serializer)
      ..add(ProblemDetails.serializer)
      ..add(ProblemType.serializer)
      ..add(Profile.serializer)
      ..add(ProfileApportment.serializer)
      ..add(RegisterDeviceTokenRequest.serializer)
      ..add(RegisterStudentRequest.serializer)
      ..add(ReorderWorkoutItemsRequest.serializer)
      ..add(ScheduleSyncItem.serializer)
      ..add(ScheduleWorkoutRequest.serializer)
      ..add(SessionPushInput.serializer)
      ..add(StartSessionRequest.serializer)
      ..add(StudentDetail.serializer)
      ..add(StudentEditLog.serializer)
      ..add(StudentListItem.serializer)
      ..add(StudentNote.serializer)
      ..add(SyncPullResponse.serializer)
      ..add(SyncPushResult.serializer)
      ..add(SyncPushSessionsRequest.serializer)
      ..add(TemplateItem.serializer)
      ..add(TemplateItemInput.serializer)
      ..add(UpdateProfileRequest.serializer)
      ..add(UpdateStudentFichaRequest.serializer)
      ..add(UploadExerciseMedia201Response.serializer)
      ..add(UploadMyProfilePhoto200Response.serializer)
      ..add(UpsertExerciseNoteRequest.serializer)
      ..add(WeekScheduleItem.serializer)
      ..add(WeeklyReport.serializer)
      ..add(WeeklyReportExercise.serializer)
      ..add(WeeklyReportSession.serializer)
      ..add(Workout.serializer)
      ..add(WorkoutItemInput.serializer)
      ..add(WorkoutListItem.serializer)
      ..add(WorkoutTemplate.serializer)
      ..add(WorkoutTemplateListItem.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(HealthApportment)]),
          () => ListBuilder<HealthApportment>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(MuscleGroup)]),
          () => ListBuilder<MuscleGroup>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Exercise)]),
          () => ListBuilder<Exercise>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(WorkoutTemplate)]),
          () => ListBuilder<WorkoutTemplate>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Workout)]),
          () => ListBuilder<Workout>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ScheduleSyncItem)]),
          () => ListBuilder<ScheduleSyncItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(NotePushInput)]),
          () => ListBuilder<NotePushInput>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ProblemType)]),
          () => ListBuilder<ProblemType>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ProfileApportment)]),
          () => ListBuilder<ProfileApportment>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(SessionPushInput)]),
          () => ListBuilder<SessionPushInput>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ExerciseMedia)]),
          () => ListBuilder<ExerciseMedia>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ExerciseMediaInput)]),
          () => ListBuilder<ExerciseMediaInput>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TemplateItem)]),
          () => ListBuilder<TemplateItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TemplateItemInput)]),
          () => ListBuilder<TemplateItemInput>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(WeeklyReportSession)]),
          () => ListBuilder<WeeklyReportSession>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(WeeklyReportExercise)]),
          () => ListBuilder<WeeklyReportExercise>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(WorkoutItem)]),
          () => ListBuilder<WorkoutItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(WorkoutItemInput)]),
          () => ListBuilder<WorkoutItemInput>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType.nullable(JsonObject)
          ]),
          () => MapBuilder<String, JsonObject?>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
