using Application.Abstractions.Messaging;

namespace Application.Workouts.Workouts.CreateFromTemplate;

/// <summary>
/// Copies a <c>WorkoutTemplate</c> (including a system default) into a new editable workout for a
/// student. The template is never modified — its items are cloned into the new workout.
/// </summary>
public sealed record CreateWorkoutFromTemplateCommand(
    Guid TemplateId,
    Guid OwnerStudentId,
    string? NameOverride)
    : ICommand<Guid>;
