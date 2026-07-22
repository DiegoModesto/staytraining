using SharedKernel;

namespace Domain.Students;

public static class StudentErrors
{
    public static Error NotFound(Guid id) =>
        Error.NotFound("Student.NotFound", $"Student with id '{id}' was not found.");

    public static readonly Error AlreadyRegistered =
        Error.Conflict("Student.AlreadyRegistered", "A profile already exists for this user.");
}
