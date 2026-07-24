using Application.Abstractions.Messaging;

namespace Application.Execution.Schedule;

/// <summary>Assigns a workout to a specific day. <paramref name="StudentId"/> is honored only for a
/// manager (professor with student.manage) — otherwise it always targets the caller.</summary>
public sealed record ScheduleWorkoutForDayCommand(Guid WorkoutId, DateOnly Date, Guid? StudentId = null)
    : ICommand<Guid>;
