using Application.Abstractions.Messaging;

namespace Application.HealthCatalog.ProblemTypes;

public sealed record CreateProblemTypeCommand(Guid BodyPartId, string Name) : ICommand<Guid>;

public sealed record UpdateProblemTypeCommand(Guid Id, string Name) : ICommand;

public sealed record DeleteProblemTypeCommand(Guid Id) : ICommand;
