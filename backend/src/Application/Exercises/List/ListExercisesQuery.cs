using Application.Abstractions.Messaging;
using Domain.Exercises;

namespace Application.Exercises.List;

/// <summary>Lists exercises for the current tenant, optionally filtered by category.</summary>
public sealed record ListExercisesQuery(ExerciseCategory? Category)
    : IQuery<IReadOnlyCollection<ExerciseListItemResponse>>;

public sealed record ExerciseListItemResponse(
    Guid Id,
    string Name,
    ExerciseCategory Category,
    Guid PrimaryMuscleGroupId,
    bool IsAerobic);
