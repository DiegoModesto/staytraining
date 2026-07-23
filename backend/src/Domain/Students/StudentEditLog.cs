namespace Domain.Students;

/// <summary>
/// Audit trail of edits made to a student's ficha by an administrator (not the student themselves).
/// Records who changed what and when, for compliance/traceability.
/// </summary>
public sealed class StudentEditLog
{
    public Guid Id { get; set; }
    public Guid StudentProfileId { get; set; }

    public Guid EditorUserId { get; set; }
    public string EditorName { get; set; } = string.Empty;

    /// <summary>Machine action code, e.g. "FichaUpdated", "ApportmentAdded", "ApportmentRemoved".</summary>
    public string Action { get; set; } = string.Empty;

    /// <summary>Human-readable summary of the change.</summary>
    public string Detail { get; set; } = string.Empty;

    public DateTimeOffset CreatedAt { get; set; }
}
