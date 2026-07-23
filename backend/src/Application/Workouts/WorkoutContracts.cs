namespace Application.Workouts;

/// <summary>Prescription entry accepted when creating/editing a template.</summary>
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

/// <summary>Prescription entry accepted when creating/editing a workout.</summary>
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

public sealed record TemplateItemResponse(
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

public sealed record WorkoutTemplateResponse(
    Guid Id,
    string Name,
    string? Description,
    Guid? ModalityId,
    string? ModalityName,
    bool IsSystemDefault,
    string? CreatorNotes,
    IReadOnlyCollection<TemplateItemResponse> Items);

public sealed record WorkoutTemplateListItemResponse(
    Guid Id,
    string Name,
    Guid? ModalityId,
    string? ModalityName,
    bool IsSystemDefault,
    int ItemCount);

public sealed record WorkoutItemResponse(
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

public sealed record WorkoutResponse(
    Guid Id,
    Guid OwnerStudentId,
    Guid? SourceTemplateId,
    string Name,
    string? Description,
    Guid? ModalityId,
    string? ModalityName,
    IReadOnlyCollection<WorkoutItemResponse> Items);

public sealed record WorkoutListItemResponse(
    Guid Id,
    string Name,
    Guid? ModalityId,
    string? ModalityName,
    int ItemCount);
