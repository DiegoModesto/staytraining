using Application.Abstractions.Messaging;

namespace Application.Workouts.Templates.GetById;

public sealed record GetWorkoutTemplateByIdQuery(Guid Id) : IQuery<WorkoutTemplateResponse>;
