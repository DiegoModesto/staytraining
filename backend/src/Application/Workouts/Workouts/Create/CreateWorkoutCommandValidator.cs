using FluentValidation;

namespace Application.Workouts.Workouts.Create;

internal sealed class CreateWorkoutCommandValidator : AbstractValidator<CreateWorkoutCommand>
{
    public CreateWorkoutCommandValidator()
    {
        // OwnerStudentId may be empty for the student self-service flow (defaults to the caller).
        RuleFor(c => c.Name).NotEmpty().MaximumLength(200);
        RuleFor(c => c.Description).MaximumLength(2000);
        RuleFor(c => c.Items).NotNull();

        RuleForEach(c => c.Items).ChildRules(i =>
        {
            i.RuleFor(x => x.ExerciseId).NotEmpty();
            i.RuleFor(x => x.Sets).GreaterThanOrEqualTo(0);
            i.RuleFor(x => x.Reps).GreaterThanOrEqualTo(0);
            i.RuleFor(x => x.RestSeconds).GreaterThanOrEqualTo(0);
            i.RuleFor(x => x.SectionLabel).MaximumLength(100);
            i.RuleFor(x => x.ProfessorComment).MaximumLength(2000);
        });
    }
}
