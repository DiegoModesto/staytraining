using Domain.Profiles;

namespace Application.Students;

public sealed record StudentListItemResponse(Guid Id, Guid UserId, string FullName, string? Email);

public sealed record HealthApportmentResponse(
    Guid Id,
    Guid BodyPartId,
    string BodyPartName,
    Guid ProblemTypeId,
    string ProblemTypeName,
    string? Observation,
    DateTimeOffset CreatedAt);

public sealed record StudentNoteResponse(
    Guid Id,
    Guid AuthorUserId,
    string AuthorName,
    string Content,
    DateTimeOffset CreatedAt);

public sealed record StudentEditLogResponse(
    Guid Id,
    Guid EditorUserId,
    string EditorName,
    string Action,
    string Detail,
    DateTimeOffset CreatedAt);

public sealed record StudentDetailResponse(
    Guid Id,
    Guid UserId,
    string FullName,
    string? Email,
    DateOnly? BirthDate,
    string? Goals,
    string? Phone,
    string? EmergencyPhone,
    BloodType BloodType,
    int? HeightCm,
    decimal? WeightKg,
    string? PhotoUrl,
    IReadOnlyCollection<HealthApportmentResponse> HealthApportments);
