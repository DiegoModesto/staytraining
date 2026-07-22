using Application.Abstractions.Messaging;

namespace Application.Workouts.Workouts.RemoveItem;

public sealed record RemoveWorkoutItemCommand(Guid WorkoutId, Guid ItemId) : ICommand;
