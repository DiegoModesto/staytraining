using SharedKernel;

namespace Domain.Modalities;

/// <summary>
/// A training modality (Musculação, Funcional, Boxe, Aeróbico, …). Formerly a fixed
/// <c>ExerciseCategory</c> enum; now a database-backed, admin-managed catalog so new modalities
/// can be created at runtime. Exercises, workouts and templates reference a modality by id.
/// </summary>
public sealed class Modality : Entity, IHasUpdatedAt
{
    public Guid Id { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }

    /// <summary>Display name, e.g. "Musculação". Unique across the catalog.</summary>
    public string Name { get; set; } = string.Empty;

    /// <summary>Accent color (hex, e.g. "#4EA8FF") used by the UI to tag the modality.</summary>
    public string ColorHex { get; set; } = "#9AA4B2";

    /// <summary>True for modalities driven by work/interval rounds rather than sets × reps (Boxe, Aeróbico).</summary>
    public bool IsIntervalBased { get; set; }

    /// <summary>Ordering hint for pickers/lists (ascending).</summary>
    public int SortOrder { get; set; }
}
