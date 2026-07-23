using FluentValidation;

namespace Application.MuscleGroups.Create;

internal sealed class CreateMuscleGroupCommandValidator : AbstractValidator<CreateMuscleGroupCommand>
{
    public CreateMuscleGroupCommandValidator()
    {
        RuleFor(c => c.Name).NotEmpty().MaximumLength(100);
        RuleFor(c => c.BodyRegion).NotEmpty().MaximumLength(100);
    }
}
