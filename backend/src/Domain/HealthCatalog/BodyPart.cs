using SharedKernel;

namespace Domain.HealthCatalog;

/// <summary>
/// A body region in the health-issue catalog (e.g. Coração, Ombro, Lombar). Global, admin-managed.
/// Groups the <see cref="ProblemType"/>s that can be picked when recording a student health apport.
/// </summary>
public sealed class BodyPart : Entity, IHasUpdatedAt
{
    public Guid Id { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }

    public string Name { get; set; } = string.Empty;
    public int SortOrder { get; set; }

    public List<ProblemType> ProblemTypes { get; set; } = [];
}
