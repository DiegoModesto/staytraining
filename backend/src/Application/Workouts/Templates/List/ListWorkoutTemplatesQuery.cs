using Application.Abstractions.Messaging;

namespace Application.Workouts.Templates.List;

public sealed record ListWorkoutTemplatesQuery(bool? OnlySystemDefaults)
    : IQuery<IReadOnlyCollection<WorkoutTemplateListItemResponse>>;
