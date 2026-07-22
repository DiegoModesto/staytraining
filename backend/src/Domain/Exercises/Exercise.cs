using SharedKernel;

namespace Domain.Exercises;

/// <summary>
/// A catalog exercise (musculação, funcional, boxe or aeróbico) with default prescription,
/// the affected muscle(s), a usage example and media (GIF / video / YouTube / muscle image).
/// </summary>
public sealed class Exercise : Entity, IHasUpdatedAt
{
    public Guid Id { get; set; }
    public Guid TenantId { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }

    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public ExerciseCategory Category { get; set; }

    /// <summary>Primary muscle group affected.</summary>
    public Guid PrimaryMuscleGroupId { get; set; }

    /// <summary>Secondary muscle groups affected (stored as a primitive collection / jsonb).</summary>
    public List<Guid> SecondaryMuscleGroupIds { get; set; } = [];

    /// <summary>Free-text example of how to perform the exercise.</summary>
    public string? UsageExample { get; set; }

    // Default prescription (suggested to the student; can be overridden per workout item).
    public int DefaultSets { get; set; }
    public int DefaultReps { get; set; }
    public int DefaultRestSeconds { get; set; }

    /// <summary>True for aerobic/interval exercises that use a work/rest timer instead of sets×reps.</summary>
    public bool IsAerobic { get; set; }

    // Default interval configuration for aerobic exercises (e.g. 60s work / 30s rest × 5 rounds).
    public int? DefaultWorkSeconds { get; set; }
    public int? DefaultIntervalRestSeconds { get; set; }
    public int? DefaultRounds { get; set; }

    public List<ExerciseMedia> Media { get; set; } = [];
}
