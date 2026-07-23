using FluentValidation;

namespace Application.Students.AddStudentNote;

internal sealed class AddStudentNoteCommandValidator : AbstractValidator<AddStudentNoteCommand>
{
    public AddStudentNoteCommandValidator()
    {
        RuleFor(c => c.StudentProfileId).NotEmpty();
        RuleFor(c => c.Content).NotEmpty().MaximumLength(4000);
    }
}
