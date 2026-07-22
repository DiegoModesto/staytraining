namespace Domain.Students;

public enum HealthObservationKind
{
    /// <summary>A health problem/condition (e.g. injury, restriction).</summary>
    HealthIssue = 0,

    /// <summary>A private note from the professor, kept on the student's sheet only.</summary>
    ProfessorNote = 1,
}

/// <summary>
/// An entry on the student's observation sheet — a health issue or a private professor note.
/// </summary>
public sealed class HealthObservation
{
    public Guid Id { get; set; }
    public Guid StudentProfileId { get; set; }
    public HealthObservationKind Kind { get; set; }

    public string Title { get; set; } = string.Empty;
    public string? Detail { get; set; }

    public DateTimeOffset CreatedAt { get; set; }
}
