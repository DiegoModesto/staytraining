using Application.Abstractions.Messaging;

namespace Application.Modalities.Delete;

public sealed record DeleteModalityCommand(Guid Id) : ICommand;
