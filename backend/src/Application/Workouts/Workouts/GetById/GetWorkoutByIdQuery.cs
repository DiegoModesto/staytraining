using Application.Abstractions.Messaging;

namespace Application.Workouts.Workouts.GetById;

public sealed record GetWorkoutByIdQuery(Guid Id) : IQuery<WorkoutResponse>;
