using SharedKernel;

namespace Domain.Execution;

/// <summary>
/// Assigns a workout to a specific day chosen by the student
/// (e.g. Monday = "Costas e Ombro", Tuesday = "Peito e Bíceps").
/// </summary>
public sealed class WorkoutSchedule : Entity, IHasUpdatedAt
{
    public Guid Id { get; set; }
    public Guid TenantId { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
    public Guid StudentId { get; set; }
    public Guid WorkoutId { get; set; }

    /// <summary>The day the workout is planned for.</summary>
    public DateOnly ScheduledDate { get; set; }

    /// <summary>Pending / Skipped (justified) / Swapped (moved to another day). Completion itself is
    /// derived from <see cref="WorkoutSession"/>, not stored here.</summary>
    public ScheduleStatus Status { get; set; } = ScheduleStatus.Pending;

    /// <summary>Short reason code when skipped/swapped (e.g. "feriado", "doenca").</summary>
    public string? JustificationReason { get; set; }

    /// <summary>Optional free-text note for the justification/swap.</summary>
    public string? JustificationNote { get; set; }

    /// <summary>On the original entry: the new day's schedule this one was swapped into.</summary>
    public Guid? SwappedToScheduleId { get; set; }

    /// <summary>On the new day's entry: the original schedule it came from.</summary>
    public Guid? SwappedFromScheduleId { get; set; }
}
