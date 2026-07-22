using Application.Abstractions.Messaging;
using Domain.Exercises;

namespace Application.Workouts.Templates.Create;

public sealed record CreateWorkoutTemplateCommand(
    string Name,
    string? Description,
    ExerciseCategory? Category,
    bool IsSystemDefault,
    string? CreatorNotes,
    IReadOnlyCollection<TemplateItemInput> Items)
    : ICommand<Guid>;
