using FluentValidation;

namespace Application.Workouts.Workouts.AddItem;

internal sealed class AddWorkoutItemCommandValidator : AbstractValidator<AddWorkoutItemCommand>
{
    public AddWorkoutItemCommandValidator()
    {
        RuleFor(c => c.WorkoutId).NotEmpty();
        RuleFor(c => c.Item.ExerciseId).NotEmpty();
        RuleFor(c => c.Item.Sets).GreaterThanOrEqualTo(0);
        RuleFor(c => c.Item.Reps).GreaterThanOrEqualTo(0);
        RuleFor(c => c.Item.RestSeconds).GreaterThanOrEqualTo(0);
        RuleFor(c => c.Item.SectionLabel).MaximumLength(100);
        RuleFor(c => c.Item.ProfessorComment).MaximumLength(2000);
    }
}
