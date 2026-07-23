using Domain.Profiles;
using SharedKernel;

namespace Domain.Students;

/// <summary>
/// The training-side profile of a student managed by a professor. Links to the auth user via
/// <see cref="UserId"/> (which is also a workout's <c>OwnerStudentId</c>).
/// </summary>
public sealed class StudentProfile : Entity, IHasUpdatedAt
{
    public Guid Id { get; set; }
    public Guid TenantId { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }

    /// <summary>Auth user id of the student (equals <c>Workout.OwnerStudentId</c>).</summary>
    public Guid UserId { get; set; }

    public string FullName { get; set; } = string.Empty;
    public string? Email { get; set; }
    public DateOnly? BirthDate { get; set; }

    // Personal data (the editable "ficha"). Required ones are enforced at the API/UI layer; kept
    // nullable here so pre-existing rows remain valid until filled in.
    public string? Phone { get; set; }
    public string? EmergencyPhone { get; set; }
    public BloodType BloodType { get; set; } = BloodType.Unknown;
    public int? HeightCm { get; set; }
    public decimal? WeightKg { get; set; }

    /// <summary>MinIO object key of the profile photo (see IFileStorage); null when none.</summary>
    public string? PhotoKey { get; set; }

    /// <summary>Training goals / general notes visible to the student.</summary>
    public string? Goals { get; set; }

    public List<HealthObservation> HealthObservations { get; set; } = [];

    /// <summary>Professor annotations on the student's sheet — visible to professors only, never to the student.</summary>
    public List<StudentNote> Notes { get; set; } = [];
}
