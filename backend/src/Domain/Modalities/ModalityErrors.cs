using SharedKernel;

namespace Domain.Modalities;

public static class ModalityErrors
{
    public static Error NotFound(Guid id) =>
        Error.NotFound("Modality.NotFound", $"Modality with id '{id}' was not found.");

    public static readonly Error NameRequired =
        Error.Validation("Modality.NameRequired", "Name is required.");

    public static Error NameNotUnique(string name) =>
        Error.Conflict("Modality.NameNotUnique", $"A modality named '{name}' already exists.");

    public static Error InUse(Guid id) =>
        Error.Conflict("Modality.InUse", $"Modality '{id}' is referenced by exercises and cannot be deleted.");
}
