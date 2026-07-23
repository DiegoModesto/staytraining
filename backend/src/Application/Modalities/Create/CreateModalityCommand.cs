using Application.Abstractions.Messaging;

namespace Application.Modalities.Create;

public sealed record CreateModalityCommand(
    string Name,
    string ColorHex,
    bool IsIntervalBased,
    int SortOrder)
    : ICommand<Guid>;
