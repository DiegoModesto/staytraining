namespace Application.HealthCatalog;

public sealed record ProblemTypeResponse(Guid Id, string Name, int SortOrder);

public sealed record BodyPartResponse(
    Guid Id,
    string Name,
    int SortOrder,
    IReadOnlyCollection<ProblemTypeResponse> ProblemTypes);
