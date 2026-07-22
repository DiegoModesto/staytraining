using Application.Abstractions.Messaging;

namespace Application.Execution.Schedule;

/// <summary>Returns the workouts scheduled for the 7 days starting at <paramref name="WeekStart"/>.</summary>
public sealed record GetWeekScheduleQuery(DateOnly WeekStart, Guid? StudentId)
    : IQuery<IReadOnlyCollection<WeekScheduleItemResponse>>;
