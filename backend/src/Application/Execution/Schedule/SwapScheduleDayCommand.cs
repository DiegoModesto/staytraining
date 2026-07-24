using Application.Abstractions.Messaging;

namespace Application.Execution.Schedule;

/// <summary>Moves a scheduled workout to another day: creates a new (pending) entry on
/// <paramref name="NewDate"/> and marks the original as swapped. Returns the new schedule id.</summary>
public sealed record SwapScheduleDayCommand(Guid ScheduleId, DateOnly NewDate, string? Reason, string? Note)
    : ICommand<Guid>;
