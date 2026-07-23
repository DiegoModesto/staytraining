namespace Domain.Students;

/// <summary>
/// A structured health note on a student's ficha: a body part + problem type (from the catalog) plus
/// an optional free-text observation. Replaces the old free-text HealthObservation. A student may have
/// several. Denormalized names are stored so history survives catalog renames/deletes.
/// </summary>
public sealed class HealthApportment
{
    public Guid Id { get; set; }
    public Guid StudentProfileId { get; set; }

    public Guid BodyPartId { get; set; }
    public string BodyPartName { get; set; } = string.Empty;
    public Guid ProblemTypeId { get; set; }
    public string ProblemTypeName { get; set; } = string.Empty;

    public string? Observation { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
}
