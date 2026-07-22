using FluentValidation;

namespace Application.Workouts.Templates.Create;

internal sealed class CreateWorkoutTemplateCommandValidator : AbstractValidator<CreateWorkoutTemplateCommand>
{
    public CreateWorkoutTemplateCommandValidator()
    {
        RuleFor(c => c.Name).NotEmpty().MaximumLength(200);
        RuleFor(c => c.Description).MaximumLength(2000);
        RuleFor(c => c.CreatorNotes).MaximumLength(4000);
        RuleFor(c => c.Items).NotNull();

        RuleForEach(c => c.Items).ChildRules(i =>
        {
            i.RuleFor(x => x.ExerciseId).NotEmpty();
            i.RuleFor(x => x.Sets).GreaterThanOrEqualTo(0);
            i.RuleFor(x => x.Reps).GreaterThanOrEqualTo(0);
            i.RuleFor(x => x.RestSeconds).GreaterThanOrEqualTo(0);
            i.RuleFor(x => x.SectionLabel).MaximumLength(100);
            i.RuleFor(x => x.CreatorNotes).MaximumLength(2000);
        });
    }
}
