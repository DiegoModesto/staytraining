using Application.Abstractions.Messaging;

namespace Application.Workouts.Workouts.Rename;

public sealed record RenameWorkoutCommand(Guid WorkoutId, string Name) : ICommand;
