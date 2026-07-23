using SharedKernel;

namespace Domain.HealthCatalog;

/// <summary>A problem/condition under a <see cref="BodyPart"/> (e.g. Cardíaco, Hérnia de disco).</summary>
public sealed class ProblemType : Entity, IHasUpdatedAt
{
    public Guid Id { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }

    public Guid BodyPartId { get; set; }
    public string Name { get; set; } = string.Empty;
    public int SortOrder { get; set; }
}
