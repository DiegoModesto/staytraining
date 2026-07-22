namespace Web.Blazor.Training;

// Enums mirror the API domain enums (numeric JSON by default).
public enum ExerciseCategory { Musculacao = 0, Funcional = 1, Boxe = 2, Aerobico = 3 }

public enum HealthObservationKind { HealthIssue = 0, ProfessorNote = 1 }

public sealed record MuscleGroupDto(Guid Id, string Name, string BodyRegion);

public sealed record ExerciseListItemDto(
    Guid Id, string Name, ExerciseCategory Category, Guid PrimaryMuscleGroupId, bool IsAerobic);

public sealed record CreateExerciseRequest(
    string Name,
    string? Description,
    ExerciseCategory Category,
    Guid PrimaryMuscleGroupId,
    string? UsageExample,
    int DefaultSets,
    int DefaultReps,
    int DefaultRestSeconds,
    bool IsAerobic);

public sealed record WorkoutTemplateListItemDto(
    Guid Id, string Name, ExerciseCategory? Category, bool IsSystemDefault, int ItemCount);

public sealed record StudentListItemDto(Guid Id, Guid UserId, string FullName, string? Email);

public sealed record HealthObservationDto(
    Guid Id, HealthObservationKind Kind, string Title, string? Detail, DateTimeOffset CreatedAt);

public sealed record StudentDetailDto(
    Guid Id,
    Guid UserId,
    string FullName,
    string? Email,
    DateOnly? BirthDate,
    string? Goals,
    IReadOnlyList<HealthObservationDto> HealthObservations);

public sealed record RegisterStudentRequest(
    Guid UserId, string FullName, string? Email, DateOnly? BirthDate, string? Goals);

public sealed record AddHealthObservationRequest(HealthObservationKind Kind, string Title, string? Detail);

public sealed record WorkoutListItemDto(Guid Id, string Name, ExerciseCategory? Category, int ItemCount);

public sealed record CreateWorkoutFromTemplateRequest(Guid TemplateId, Guid OwnerStudentId, string? NameOverride);

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
    ExerciseCategory? Category,
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
    ExerciseCategory? Category,
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
    ExerciseCategory? Category,
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
    ExerciseCategory? Category,
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
