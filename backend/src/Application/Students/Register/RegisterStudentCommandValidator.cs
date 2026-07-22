using FluentValidation;

namespace Application.Students.Register;

internal sealed class RegisterStudentCommandValidator : AbstractValidator<RegisterStudentCommand>
{
    public RegisterStudentCommandValidator()
    {
        RuleFor(c => c.UserId).NotEmpty();
        RuleFor(c => c.FullName).NotEmpty().MaximumLength(200);
        RuleFor(c => c.Email).MaximumLength(320);
        RuleFor(c => c.Goals).MaximumLength(4000);
    }
}
