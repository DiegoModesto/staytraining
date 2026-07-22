using SharedKernel;

namespace Domain.Execution;

/// <summary>
/// A single execution of a workout by a student. Drives "last performed", pending detection
/// and the weekly report. Notes are recorded per exercise via <see cref="ExerciseNote"/>.
/// </summary>
public sealed class WorkoutSession : Entity
{
    public Guid Id { get; set; }
    public Guid TenantId { get; set; }
    public Guid StudentId { get; set; }
    public Guid WorkoutId { get; set; }

    public DateTimeOffset StartedAt { get; set; }
    public DateTimeOffset? CompletedAt { get; set; }

    /// <summary>Self-rated execution score (0–5) recorded on completion.</summary>
    public int? CompletionRating { get; set; }

    /// <summary>Overall comment recorded on completion.</summary>
    public string? OverallComment { get; set; }

    public List<ExerciseNote> Notes { get; set; } = [];
}
