using FluentValidation;

namespace Application.Students.AddHealthObservation;

internal sealed class AddHealthObservationCommandValidator : AbstractValidator<AddHealthObservationCommand>
{
    public AddHealthObservationCommandValidator()
    {
        RuleFor(c => c.StudentProfileId).NotEmpty();
        RuleFor(c => c.Kind).IsInEnum();
        RuleFor(c => c.Title).NotEmpty().MaximumLength(200);
        RuleFor(c => c.Detail).MaximumLength(4000);
    }
}
