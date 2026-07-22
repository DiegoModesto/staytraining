using SharedKernel;

namespace Domain.Exercises;

public static class ExerciseErrors
{
    public static Error NotFound(Guid id) =>
        Error.NotFound("Exercise.NotFound", $"Exercise with id '{id}' was not found.");

    public static readonly Error NameRequired =
        Error.Validation("Exercise.NameRequired", "Name is required.");
}
