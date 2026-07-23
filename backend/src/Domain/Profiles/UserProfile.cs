using SharedKernel;

namespace Domain.Profiles;

/// <summary>
/// Personal profile of a non-student user (professor / admin) — "Meu perfil". Students use their
/// richer <see cref="Domain.Students.StudentProfile"/> instead (which doubles as the editable ficha).
/// Keyed by the auth <see cref="UserId"/>, one row per user per tenant.
/// </summary>
public sealed class UserProfile : Entity, IHasUpdatedAt
{
    public Guid Id { get; set; }
    public Guid TenantId { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }

    /// <summary>Auth user id (the token <c>sub</c>).</summary>
    public Guid UserId { get; set; }

    public string FullName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? Phone { get; set; }
    public BloodType BloodType { get; set; } = BloodType.Unknown;
    public int? HeightCm { get; set; }
    public decimal? WeightKg { get; set; }

    /// <summary>MinIO object key of the profile photo (see IFileStorage); null when none.</summary>
    public string? PhotoKey { get; set; }
}
