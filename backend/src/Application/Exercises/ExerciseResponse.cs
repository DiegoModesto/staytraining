using Domain.Exercises;

namespace Application.Exercises;

public sealed record ExerciseMediaResponse(
    Guid Id,
    ExerciseMediaKind Kind,
    string? StorageKey,
    string? Url,
    string? ContentType,
    long? SizeBytes);

public sealed record ExerciseResponse(
    Guid Id,
    string Name,
    string? Description,
    Guid ModalityId,
    string ModalityName,
    Guid PrimaryMuscleGroupId,
    IReadOnlyCollection<Guid> SecondaryMuscleGroupIds,
    string? UsageExample,
    int DefaultSets,
    int DefaultReps,
    int DefaultRestSeconds,
    bool IsAerobic,
    int? DefaultWorkSeconds,
    int? DefaultIntervalRestSeconds,
    int? DefaultRounds,
    IReadOnlyCollection<ExerciseMediaResponse> Media);
