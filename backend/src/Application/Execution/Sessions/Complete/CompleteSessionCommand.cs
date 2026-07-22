using Application.Abstractions.Messaging;

namespace Application.Execution.Sessions.Complete;

/// <summary>Finalizes a session with an execution rating and an overall comment.</summary>
public sealed record CompleteSessionCommand(Guid SessionId, int? CompletionRating, string? OverallComment)
    : ICommand;
