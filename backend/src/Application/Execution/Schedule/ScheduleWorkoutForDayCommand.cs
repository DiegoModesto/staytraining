using Application.Abstractions.Messaging;

namespace Application.Execution.Schedule;

/// <summary>Assigns a workout to a specific day for the current student.</summary>
public sealed record ScheduleWorkoutForDayCommand(Guid WorkoutId, DateOnly Date) : ICommand<Guid>;
