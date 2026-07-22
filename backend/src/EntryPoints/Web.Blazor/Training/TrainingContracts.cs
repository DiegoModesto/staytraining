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
