using FluentValidation;

namespace Application.Questions.Ask;

internal sealed class AskQuestionCommandValidator : AbstractValidator<AskQuestionCommand>
{
    public AskQuestionCommandValidator()
    {
        RuleFor(c => c.Text).NotEmpty().MaximumLength(4000);
        RuleFor(c => c)
            .Must(c => c.WorkoutId is not null || c.ExerciseId is not null)
            .WithMessage("A question must reference a workout or an exercise.");
    }
}
