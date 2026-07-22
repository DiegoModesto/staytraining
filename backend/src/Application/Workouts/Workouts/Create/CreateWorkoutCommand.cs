using Application.Abstractions.Messaging;
using Domain.Exercises;

namespace Application.Workouts.Workouts.Create;

/// <summary>Creates a workout from scratch for a student.</summary>
public sealed record CreateWorkoutCommand(
    Guid OwnerStudentId,
    string Name,
    string? Description,
    ExerciseCategory? Category,
    IReadOnlyCollection<WorkoutItemInput> Items)
    : ICommand<Guid>;
