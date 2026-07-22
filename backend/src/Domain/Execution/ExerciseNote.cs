namespace Domain.Execution;

/// <summary>
/// A note recorded for one exercise during a session (load, pain, comment, sets/reps done).
/// Segmented by day (via the parent session) and exercise, enabling a per-day/per-exercise history.
/// </summary>
public sealed class ExerciseNote
{
    public Guid Id { get; set; }
    public Guid WorkoutSessionId { get; set; }
    public Guid WorkoutItemId { get; set; }

    /// <summary>Denormalized for reporting/aggregation across sessions.</summary>
    public Guid ExerciseId { get; set; }

    public decimal? LoadKg { get; set; }
    public bool PainFlag { get; set; }
    public string? PainNote { get; set; }
    public string? Comment { get; set; }
    public int? PerformedSets { get; set; }
    public int? PerformedReps { get; set; }

    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset? UpdatedAt { get; set; }
}
