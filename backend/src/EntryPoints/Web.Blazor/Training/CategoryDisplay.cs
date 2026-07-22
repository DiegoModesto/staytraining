namespace Web.Blazor.Training;

/// <summary>Portuguese labels + VOLT category colors for <see cref="ExerciseCategory"/> (UI helper).</summary>
public static class CategoryDisplay
{
    public static string Label(ExerciseCategory? category) => category switch
    {
        ExerciseCategory.Musculacao => "Musculação",
        ExerciseCategory.Funcional => "Funcional",
        ExerciseCategory.Boxe => "Boxe",
        ExerciseCategory.Aerobico => "Aeróbico",
        _ => "—",
    };

    public static string Color(ExerciseCategory? category) => category switch
    {
        ExerciseCategory.Musculacao => "#4EA8FF",
        ExerciseCategory.Funcional => "#2FD37A",
        ExerciseCategory.Boxe => "#FF4757",
        ExerciseCategory.Aerobico => "#FFB020",
        _ => "#9AA4B2",
    };

    /// <summary>True for modalities driven by work/interval rounds rather than sets×reps.</summary>
    public static bool IsIntervalBased(ExerciseCategory? category) =>
        category is ExerciseCategory.Boxe or ExerciseCategory.Aerobico;
}
