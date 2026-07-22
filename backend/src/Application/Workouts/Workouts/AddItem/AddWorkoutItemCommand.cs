using Application.Abstractions.Messaging;

namespace Application.Workouts.Workouts.AddItem;

public sealed record AddWorkoutItemCommand(Guid WorkoutId, WorkoutItemInput Item) : ICommand<Guid>;
