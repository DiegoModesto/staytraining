using Application.Abstractions.Messaging;

namespace Application.HealthCatalog.BodyParts;

public sealed record CreateBodyPartCommand(string Name) : ICommand<Guid>;

public sealed record UpdateBodyPartCommand(Guid Id, string Name) : ICommand;

public sealed record DeleteBodyPartCommand(Guid Id) : ICommand;
