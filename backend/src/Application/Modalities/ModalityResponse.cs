namespace Application.Modalities;

public sealed record ModalityResponse(
    Guid Id,
    string Name,
    string ColorHex,
    bool IsIntervalBased,
    int SortOrder);
