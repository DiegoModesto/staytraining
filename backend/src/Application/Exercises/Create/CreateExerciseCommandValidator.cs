using FluentValidation;

namespace Application.Exercises.Create;

internal sealed class CreateExerciseCommandValidator : AbstractValidator<CreateExerciseCommand>
{
    public CreateExerciseCommandValidator()
    {
        RuleFor(c => c.Name).NotEmpty().MaximumLength(200);
        RuleFor(c => c.Description).MaximumLength(2000);
        RuleFor(c => c.UsageExample).MaximumLength(4000);
        RuleFor(c => c.Category).IsInEnum();
        RuleFor(c => c.PrimaryMuscleGroupId).NotEmpty();

        RuleFor(c => c.DefaultSets).GreaterThanOrEqualTo(0);
        RuleFor(c => c.DefaultReps).GreaterThanOrEqualTo(0);
        RuleFor(c => c.DefaultRestSeconds).GreaterThanOrEqualTo(0);

        When(c => c.IsAerobic, () =>
        {
            RuleFor(c => c.DefaultWorkSeconds).GreaterThan(0)
                .When(c => c.DefaultWorkSeconds.HasValue);
            RuleFor(c => c.DefaultRounds).GreaterThan(0)
                .When(c => c.DefaultRounds.HasValue);
        });

        RuleForEach(c => c.Media).ChildRules(m =>
        {
            m.RuleFor(x => x.Kind).IsInEnum();
            m.RuleFor(x => x.Url).MaximumLength(2048);
            m.RuleFor(x => x.StorageKey).MaximumLength(1024);
        });
    }
}
