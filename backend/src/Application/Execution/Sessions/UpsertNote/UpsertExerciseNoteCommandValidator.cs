using FluentValidation;

namespace Application.Execution.Sessions.UpsertNote;

internal sealed class UpsertExerciseNoteCommandValidator : AbstractValidator<UpsertExerciseNoteCommand>
{
    public UpsertExerciseNoteCommandValidator()
    {
        RuleFor(c => c.SessionId).NotEmpty();
        RuleFor(c => c.WorkoutItemId).NotEmpty();
        RuleFor(c => c.ExerciseId).NotEmpty();
        RuleFor(c => c.LoadKg).GreaterThanOrEqualTo(0).When(c => c.LoadKg.HasValue);
        RuleFor(c => c.PainNote).MaximumLength(2000);
        RuleFor(c => c.Comment).MaximumLength(4000);
    }
}
