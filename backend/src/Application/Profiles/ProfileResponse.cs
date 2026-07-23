using Domain.Profiles;

namespace Application.Profiles;

/// <summary>The current user's profile ("Meu perfil"). For students it maps to their StudentProfile
/// (ficha) and includes <see cref="EmergencyPhone"/>; for professors/admins it maps to UserProfile.</summary>
public sealed record ProfileResponse(
    bool IsStudent,
    string FullName,
    string Email,
    string? Phone,
    string? EmergencyPhone,
    BloodType BloodType,
    int? HeightCm,
    decimal? WeightKg,
    string? PhotoUrl);
