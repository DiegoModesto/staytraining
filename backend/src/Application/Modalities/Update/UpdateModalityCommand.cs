using Application.Abstractions.Messaging;

namespace Application.Modalities.Update;

public sealed record UpdateModalityCommand(
    Guid Id,
    string Name,
    string ColorHex,
    bool IsIntervalBased,
    int SortOrder)
    : ICommand;
