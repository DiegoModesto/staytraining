using SharedKernel;

namespace Domain.MuscleGroups;

public static class MuscleGroupErrors
{
    public static Error NotFound(Guid id) =>
        Error.NotFound("MuscleGroup.NotFound", $"Muscle group with id '{id}' was not found.");
}
