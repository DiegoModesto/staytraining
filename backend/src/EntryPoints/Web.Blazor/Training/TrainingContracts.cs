namespace Web.Blazor.Training;

// Mirrors Domain.Profiles.BloodType (numeric JSON).
public enum BloodType { Unknown = 0, APositive, ANegative, BPositive, BNegative, AbPositive, AbNegative, OPositive, ONegative }

public sealed record ProfileDto(
    bool IsStudent,
    string FullName,
    string Email,
    string? Phone,
    string? EmergencyPhone,
    BloodType BloodType,
    int? HeightCm,
    decimal? WeightKg,
    string? PhotoUrl);

public sealed record UpdateProfileRequest(
    string FullName,
    string Email,
    string? Phone,
    string? EmergencyPhone,
    BloodType BloodType,
    int? HeightCm,
    decimal? WeightKg);

public sealed record UploadPhotoResponse(string Key, string PhotoUrl);

public sealed record MuscleGroupDto(Guid Id, string Name, string BodyRegion);

public sealed record CreateMuscleGroupRequest(string Name, string BodyRegion);

public sealed record UpdateMuscleGroupRequest(string Name, string BodyRegion);

// ---- Modalities (admin-managed catalog) ----
public sealed record ModalityDto(Guid Id, string Name, string ColorHex, bool IsIntervalBased, int SortOrder);

public sealed record CreateModalityRequest(string Name, string ColorHex, bool IsIntervalBased, int SortOrder);

public sealed record UpdateModalityRequest(string Name, string ColorHex, bool IsIntervalBased, int SortOrder);

public sealed record ExerciseListItemDto(
    Guid Id, string Name, Guid ModalityId, string ModalityName, Guid PrimaryMuscleGroupId, bool IsAerobic);

public sealed record CreateExerciseRequest(
    string Name,
    string? Description,
    Guid ModalityId,
    Guid PrimaryMuscleGroupId,
    string? UsageExample,
    int DefaultSets,
    int DefaultReps,
    int DefaultRestSeconds,
    bool IsAerobic);

public sealed record WorkoutTemplateListItemDto(
    Guid Id, string Name, Guid? ModalityId, string? ModalityName, bool IsSystemDefault, int ItemCount);

public sealed record StudentListItemDto(Guid Id, Guid UserId, string FullName, string? Email);

public sealed record HealthApportmentDto(
    Guid Id, Guid BodyPartId, string BodyPartName, Guid ProblemTypeId, string ProblemTypeName,
    string? Observation, DateTimeOffset CreatedAt);

public sealed record StudentDetailDto(
    Guid Id,
    Guid UserId,
    string FullName,
    string? Email,
    DateOnly? BirthDate,
    string? Goals,
    string? Phone,
    string? EmergencyPhone,
    BloodType BloodType,
    int? HeightCm,
    decimal? WeightKg,
    string? PhotoUrl,
    IReadOnlyList<HealthApportmentDto> HealthApportments);

public sealed record RegisterStudentRequest(
    Guid UserId, string FullName, string? Email, DateOnly? BirthDate, string? Goals);

public sealed record AddApportmentRequest(Guid BodyPartId, Guid ProblemTypeId, string? Observation);

public sealed record UpdateStudentFichaRequest(
    string FullName, string? Email, string? Phone, string? EmergencyPhone,
    BloodType BloodType, int? HeightCm, decimal? WeightKg, string? Goals);

public sealed record StudentEditLogDto(
    Guid Id, Guid EditorUserId, string EditorName, string Action, string Detail, DateTimeOffset CreatedAt);

// Health-issue catalog (body part -> problem types), admin-managed under Configurações.
public sealed record ProblemTypeDto(Guid Id, string Name, int SortOrder);
public sealed record BodyPartDto(Guid Id, string Name, int SortOrder, IReadOnlyList<ProblemTypeDto> ProblemTypes);
public sealed record CatalogNameRequest(string Name);
public sealed record CreateProblemTypeRequest(Guid BodyPartId, string Name);

public sealed record StudentNoteDto(
    Guid Id, Guid AuthorUserId, string AuthorName, string Content, DateTimeOffset CreatedAt);

public sealed record AddStudentNoteRequest(string Content);

public sealed record WorkoutListItemDto(
    Guid Id, string Name, Guid? ModalityId, string? ModalityName, int ItemCount);

public sealed record CreateWorkoutFromTemplateRequest(Guid TemplateId, Guid OwnerStudentId, string? NameOverride);

public sealed record RenameWorkoutRequest(string Name);

public sealed record IdResponse(Guid Id);

// ---- Workout building (custom, item-by-item) ----

/// <summary>Prescription entry when creating/editing a workout or template.</summary>
public sealed record WorkoutItemInput(
    Guid ExerciseId,
    int Order,
    string? SectionLabel,
    int Sets,
    int Reps,
    int RestSeconds,
    int? DurationSeconds,
    int? WorkSeconds,
    int? IntervalRestSeconds,
    int? Rounds,
    string? ProfessorComment);

public sealed record CreateWorkoutRequest(
    Guid OwnerStudentId,
    string Name,
    string? Description,
    Guid? ModalityId,
    IReadOnlyCollection<WorkoutItemInput> Items);

public sealed record WorkoutItemDto(
    Guid Id,
    Guid ExerciseId,
    int Order,
    string? SectionLabel,
    int Sets,
    int Reps,
    int RestSeconds,
    int? DurationSeconds,
    int? WorkSeconds,
    int? IntervalRestSeconds,
    int? Rounds,
    string? ProfessorComment);

public sealed record WorkoutDetailDto(
    Guid Id,
    Guid OwnerStudentId,
    Guid? SourceTemplateId,
    string Name,
    string? Description,
    Guid? ModalityId,
    string? ModalityName,
    IReadOnlyList<WorkoutItemDto> Items);

public sealed record ReorderWorkoutItemsRequest(IReadOnlyList<Guid> OrderedItemIds);

// ---- Templates (builder) ----

public sealed record TemplateItemInput(
    Guid ExerciseId,
    int Order,
    string? SectionLabel,
    int Sets,
    int Reps,
    int RestSeconds,
    int? DurationSeconds,
    int? WorkSeconds,
    int? IntervalRestSeconds,
    int? Rounds,
    string? CreatorNotes);

public sealed record CreateWorkoutTemplateRequest(
    string Name,
    string? Description,
    Guid? ModalityId,
    bool IsSystemDefault,
    string? CreatorNotes,
    IReadOnlyCollection<TemplateItemInput> Items);

public sealed record TemplateItemDto(
    Guid Id,
    Guid ExerciseId,
    int Order,
    string? SectionLabel,
    int Sets,
    int Reps,
    int RestSeconds,
    int? DurationSeconds,
    int? WorkSeconds,
    int? IntervalRestSeconds,
    int? Rounds,
    string? CreatorNotes);

public sealed record WorkoutTemplateDetailDto(
    Guid Id,
    string Name,
    string? Description,
    Guid? ModalityId,
    string? ModalityName,
    bool IsSystemDefault,
    string? CreatorNotes,
    IReadOnlyList<TemplateItemDto> Items);

// ---- Execution: sessions, notes, schedule, report ----

public sealed record CompleteSessionRequest(int? CompletionRating, string? OverallComment);

public sealed record UpsertExerciseNoteRequest(
    Guid WorkoutItemId,
    Guid ExerciseId,
    decimal? LoadKg,
    bool PainFlag,
    string? PainNote,
    string? Comment,
    int? PerformedSets,
    int? PerformedReps);

public sealed record ExerciseNoteDto(
    Guid Id,
    Guid SessionId,
    DateTimeOffset SessionDate,
    Guid WorkoutItemId,
    Guid ExerciseId,
    decimal? LoadKg,
    bool PainFlag,
    string? PainNote,
    string? Comment,
    int? PerformedSets,
    int? PerformedReps,
    DateTimeOffset CreatedAt);

public sealed record WeekScheduleItemDto(Guid ScheduleId, DateOnly Date, Guid WorkoutId, string WorkoutName);

public sealed record ScheduleWorkoutRequest(Guid WorkoutId, DateOnly Date);

public sealed record WeeklyReportSessionDto(
    Guid SessionId, Guid WorkoutId, DateTimeOffset StartedAt, DateTimeOffset? CompletedAt, int? Rating, int NoteCount);

public sealed record WeeklyReportExerciseDto(
    Guid ExerciseId, int TimesPerformed, int TotalSets, int TotalReps, decimal? MaxLoadKg);

public sealed record WeeklyReportDto(
    DateOnly WeekStart,
    DateOnly WeekEnd,
    int SessionCount,
    int CompletedSessionCount,
    double? AverageRating,
    int DistinctWorkoutCount,
    IReadOnlyList<WeeklyReportSessionDto> Sessions,
    IReadOnlyList<WeeklyReportExerciseDto> Exercises);
