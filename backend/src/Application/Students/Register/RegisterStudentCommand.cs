using Application.Abstractions.Messaging;

namespace Application.Students.Register;

public sealed record RegisterStudentCommand(
    Guid UserId,
    string FullName,
    string? Email,
    DateOnly? BirthDate,
    string? Goals)
    : ICommand<Guid>;
