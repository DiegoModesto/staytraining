using Domain.Exercises;
using SharedKernel;

namespace Domain.Workouts;

/// <summary>
/// A pre-built, reusable workout (e.g. "Costas e Ombro"). System defaults
/// (<see cref="IsSystemDefault"/>) cannot be edited — they are copied into an editable
/// <see cref="Workout"/> instead.
/// </summary>
public sealed class WorkoutTemplate : Entity, IHasUpdatedAt
{
    public Guid Id { get; set; }
    public Guid TenantId { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }

    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public ExerciseCategory? Category { get; set; }

    /// <summary>When true, the template is read-only and may only be copied, never edited.</summary>
    public bool IsSystemDefault { get; set; }

    /// <summary>General note from the template author, shown during execution.</summary>
    public string? CreatorNotes { get; set; }

    public List<TemplateItem> Items { get; set; } = [];
}
