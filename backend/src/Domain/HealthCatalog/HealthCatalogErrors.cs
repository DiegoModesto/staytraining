using SharedKernel;

namespace Domain.HealthCatalog;

public static class HealthCatalogErrors
{
    public static Error BodyPartNotFound(Guid id) =>
        Error.NotFound("BodyPart.NotFound", $"Body part with id '{id}' was not found.");

    public static Error ProblemTypeNotFound(Guid id) =>
        Error.NotFound("ProblemType.NotFound", $"Problem type with id '{id}' was not found.");

    public static Error BodyPartInUse(Guid id) =>
        Error.Conflict("BodyPart.InUse", $"Body part '{id}' has problem types or apports and cannot be deleted.");

    public static Error ProblemTypeInUse(Guid id) =>
        Error.Conflict("ProblemType.InUse", $"Problem type '{id}' is referenced by health apports and cannot be deleted.");
}
