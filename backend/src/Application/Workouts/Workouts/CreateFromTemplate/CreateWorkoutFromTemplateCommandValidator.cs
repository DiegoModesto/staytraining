using FluentValidation;

namespace Application.Workouts.Workouts.CreateFromTemplate;

internal sealed class CreateWorkoutFromTemplateCommandValidator
    : AbstractValidator<CreateWorkoutFromTemplateCommand>
{
    public CreateWorkoutFromTemplateCommandValidator()
    {
        RuleFor(c => c.TemplateId).NotEmpty();
        // OwnerStudentId may be empty for the student self-service flow (defaults to the caller).
        RuleFor(c => c.NameOverride).MaximumLength(200);
    }
}
