using Domain.Exercises;
using SharedKernel;

namespace Domain.Workouts;

/// <summary>
/// A student's own workout — built from scratch or copied from a <see cref="WorkoutTemplate"/>
/// (recorded in <see cref="SourceTemplateId"/>). Fully editable by the owner and the professor.
/// </summary>
public sealed class Workout : Entity, IHasUpdatedAt
{
    public Guid Id { get; set; }
    public Guid TenantId { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }

    /// <summary>The student (user) who owns this workout.</summary>
    public Guid OwnerStudentId { get; set; }

    /// <summary>Template this workout was copied from, if any.</summary>
    public Guid? SourceTemplateId { get; set; }

    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public ExerciseCategory? Category { get; set; }

    public List<WorkoutItem> Items { get; set; } = [];
}
