using Domain.Profiles;

namespace Application.Profiles;

public sealed record ProfileApportmentResponse(
    Guid Id, string BodyPartName, string ProblemTypeName, string? Observation);

/// <summary>The current user's profile ("Meu perfil"). For students it maps to their StudentProfile
/// (ficha) and includes <see cref="EmergencyPhone"/> + <see cref="Apportments"/>; for professors/admins
/// it maps to UserProfile (with no apports).</summary>
public sealed record ProfileResponse(
    bool IsStudent,
    string FullName,
    string Email,
    string? Phone,
    string? EmergencyPhone,
    BloodType BloodType,
    int? HeightCm,
    decimal? WeightKg,
    string? PhotoUrl,
    IReadOnlyCollection<ProfileApportmentResponse> Apportments);
