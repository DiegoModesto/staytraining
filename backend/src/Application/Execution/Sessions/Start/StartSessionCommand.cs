using Application.Abstractions.Messaging;

namespace Application.Execution.Sessions.Start;

/// <summary>Starts a workout session for the current student.</summary>
public sealed record StartSessionCommand(Guid WorkoutId) : ICommand<Guid>;
