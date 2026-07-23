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

    /// <summary>Training goals / general notes visible to the student.</summary>
    public string? Goals { get; set; }

    public List<HealthObservation> HealthObservations { get; set; } = [];

    /// <summary>Professor annotations on the student's sheet — visible to professors only, never to the student.</summary>
    public List<StudentNote> Notes { get; set; } = [];
}
