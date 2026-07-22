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
}
