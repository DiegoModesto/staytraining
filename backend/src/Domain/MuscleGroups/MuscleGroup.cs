using SharedKernel;

namespace Domain.MuscleGroups;

/// <summary>
/// Reference data describing a muscle group affected by an exercise (e.g. Costas, Ombro, Peito).
/// Global (not tenant-scoped) — shared across the whole catalog.
/// </summary>
public sealed class MuscleGroup : Entity, IHasUpdatedAt
{
    public Guid Id { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
    public string Name { get; set; } = string.Empty;

    /// <summary>Coarse body region for grouping (e.g. "Superiores", "Inferiores", "Core").</summary>
    public string BodyRegion { get; set; } = string.Empty;
}
