using Application.Abstractions.Messaging;
using Domain.Exercises;

namespace Application.Exercises.Create;

public sealed record CreateExerciseCommand(
    string Name,
    string? Description,
    ExerciseCategory Category,
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
