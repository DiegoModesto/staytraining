using FluentValidation;

namespace Application.MuscleGroups.Update;

internal sealed class UpdateMuscleGroupCommandValidator : AbstractValidator<UpdateMuscleGroupCommand>
{
    public UpdateMuscleGroupCommandValidator()
    {
        RuleFor(c => c.Id).NotEmpty();
        RuleFor(c => c.Name).NotEmpty().MaximumLength(100);
        RuleFor(c => c.BodyRegion).NotEmpty().MaximumLength(100);
    }
}
