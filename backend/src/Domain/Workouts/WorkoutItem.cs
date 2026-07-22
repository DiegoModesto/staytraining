namespace Domain.Workouts;

/// <summary>An exercise entry inside a student's <see cref="Workout"/> with its prescription.</summary>
public sealed class WorkoutItem
{
    public Guid Id { get; set; }
    public Guid WorkoutId { get; set; }
    public Guid ExerciseId { get; set; }

    /// <summary>Display order within the workout.</summary>
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

    /// <summary>Read-only comment from the professor, shown to the student during execution.</summary>
    public string? ProfessorComment { get; set; }
}
