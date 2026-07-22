using SharedKernel;

namespace Domain.Workouts;

public static class WorkoutTemplateErrors
{
    public static Error NotFound(Guid id) =>
        Error.NotFound("WorkoutTemplate.NotFound", $"Workout template with id '{id}' was not found.");

    public static readonly Error SystemDefaultReadOnly =
        Error.Conflict("WorkoutTemplate.SystemDefaultReadOnly",
            "System default templates cannot be edited. Copy the template into a workout instead.");
}

public static class WorkoutErrors
{
    public static Error NotFound(Guid id) =>
        Error.NotFound("Workout.NotFound", $"Workout with id '{id}' was not found.");

    public static Error ItemNotFound(Guid id) =>
        Error.NotFound("Workout.ItemNotFound", $"Workout item with id '{id}' was not found.");
}
