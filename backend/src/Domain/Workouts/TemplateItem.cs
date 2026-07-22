namespace Domain.Workouts;

/// <summary>An exercise entry inside a <see cref="WorkoutTemplate"/> with its default prescription.</summary>
public sealed class TemplateItem
{
    public Guid Id { get; set; }
    public Guid WorkoutTemplateId { get; set; }
    public Guid ExerciseId { get; set; }

    /// <summary>Display order within the template.</summary>
    public int Order { get; set; }

    /// <summary>Grouping label shown in the UI (e.g. "Costas", "Ombro").</summary>
    public string? SectionLabel { get; set; }

    public int Sets { get; set; }
    public int Reps { get; set; }
    public int RestSeconds { get; set; }

    // Aerobic / interval prescription.
    public int? DurationSeconds { get; set; }
    public int? WorkSeconds { get; set; }
    public int? IntervalRestSeconds { get; set; }
    public int? Rounds { get; set; }

    /// <summary>Note from whoever built the template, shown during execution.</summary>
    public string? CreatorNotes { get; set; }
}
