using Application.Abstractions.Messaging;

namespace Application.Workouts.Templates.Create;

public sealed record CreateWorkoutTemplateCommand(
    string Name,
    string? Description,
    Guid? ModalityId,
    bool IsSystemDefault,
    string? CreatorNotes,
    IReadOnlyCollection<TemplateItemInput> Items)
    : ICommand<Guid>;
