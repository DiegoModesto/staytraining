using SharedKernel;

namespace Domain.MuscleGroups;

public static class MuscleGroupErrors
{
    public static Error NotFound(Guid id) =>
        Error.NotFound("MuscleGroup.NotFound", $"Muscle group with id '{id}' was not found.");

    public static Error NameNotUnique(string name) =>
        Error.Conflict("MuscleGroup.NameNotUnique", $"A muscle group named '{name}' already exists.");

    public static Error InUse(Guid id) =>
        Error.Conflict("MuscleGroup.InUse", $"Muscle group '{id}' is referenced by exercises and cannot be deleted.");
}
