using Application.Abstractions.Messaging;

namespace Application.Workouts.Workouts.Create;

/// <summary>Creates a workout from scratch for a student.</summary>
public sealed record CreateWorkoutCommand(
    Guid OwnerStudentId,
    string Name,
    string? Description,
    Guid? ModalityId,
    IReadOnlyCollection<WorkoutItemInput> Items)
    : ICommand<Guid>;
