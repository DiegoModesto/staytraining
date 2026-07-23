using Domain.Students;

namespace Application.Students;

public sealed record StudentListItemResponse(Guid Id, Guid UserId, string FullName, string? Email);

public sealed record HealthObservationResponse(
    Guid Id,
    HealthObservationKind Kind,
    string Title,
    string? Detail,
    DateTimeOffset CreatedAt);

public sealed record StudentNoteResponse(
    Guid Id,
    Guid AuthorUserId,
    string AuthorName,
    string Content,
    DateTimeOffset CreatedAt);

public sealed record StudentDetailResponse(
    Guid Id,
    Guid UserId,
    string FullName,
    string? Email,
    DateOnly? BirthDate,
    string? Goals,
    IReadOnlyCollection<HealthObservationResponse> HealthObservations);
