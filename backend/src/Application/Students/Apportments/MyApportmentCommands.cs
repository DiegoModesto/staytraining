using Application.Abstractions.Messaging;

namespace Application.Students.Apportments;

/// <summary>Adds a health apport to the CURRENT user's own ficha (student self-service).</summary>
public sealed record AddMyApportmentCommand(Guid BodyPartId, Guid ProblemTypeId, string? Observation) : ICommand<Guid>;

/// <summary>Removes a health apport from the current user's own ficha.</summary>
public sealed record RemoveMyApportmentCommand(Guid ApportmentId) : ICommand;
