using Application.Abstractions.Messaging;

namespace Application.Exercises.Create;

public sealed record CreateExerciseCommand(
    string Name,
    string? Description,
    Guid ModalityId,
    Guid PrimaryMuscleGroupId,
    IReadOnlyCollection<Guid>? SecondaryMuscleGroupIds,
    string? UsageExample,
    int DefaultSets,
    int DefaultReps,
    int DefaultRestSeconds,
    bool IsAerobic,
    int? DefaultWorkSeconds,
    int? DefaultIntervalRestSeconds,
    int? DefaultRounds,
    IReadOnlyCollection<ExerciseMediaInput>? Media)
    : ICommand<Guid>;
