namespace Domain.Students;

/// <summary>
/// A free-text annotation a professor keeps on a student's sheet. Visible to every professor
/// in the tenant, never to the student. Records who wrote it (denormalized at write time, since
/// the training bounded context has no user table) and when.
/// </summary>
public sealed class StudentNote
{
    public Guid Id { get; set; }
    public Guid StudentProfileId { get; set; }

    /// <summary>Auth user id (<c>sub</c>) of the professor who wrote the annotation.</summary>
    public Guid AuthorUserId { get; set; }

    /// <summary>Display name of the author, captured from the token when the note was written.</summary>
    public string AuthorName { get; set; } = string.Empty;

    public string Content { get; set; } = string.Empty;

    public DateTimeOffset CreatedAt { get; set; }
}
