using Application.Abstractions.Messaging;

namespace Application.Workouts.Workouts.Delete;

public sealed record DeleteWorkoutCommand(Guid WorkoutId) : ICommand;
