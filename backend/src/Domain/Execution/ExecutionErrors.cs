using SharedKernel;

namespace Domain.Execution;

public static class WorkoutSessionErrors
{
    public static Error NotFound(Guid id) =>
        Error.NotFound("WorkoutSession.NotFound", $"Workout session with id '{id}' was not found.");

    public static readonly Error AlreadyCompleted =
        Error.Conflict("WorkoutSession.AlreadyCompleted", "This session has already been completed.");
}

public static class WorkoutScheduleErrors
{
    public static Error NotFound(Guid id) =>
        Error.NotFound("WorkoutSchedule.NotFound", $"Workout schedule with id '{id}' was not found.");
}
