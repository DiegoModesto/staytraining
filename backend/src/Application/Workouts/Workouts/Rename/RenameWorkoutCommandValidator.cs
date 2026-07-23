using FluentValidation;

namespace Application.Workouts.Workouts.Rename;

internal sealed class RenameWorkoutCommandValidator : AbstractValidator<RenameWorkoutCommand>
{
    public RenameWorkoutCommandValidator()
    {
        RuleFor(c => c.WorkoutId).NotEmpty();
        RuleFor(c => c.Name).NotEmpty().MaximumLength(200);
    }
}
