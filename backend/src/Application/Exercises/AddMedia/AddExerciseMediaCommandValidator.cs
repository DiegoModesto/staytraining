using FluentValidation;

namespace Application.Exercises.AddMedia;

internal sealed class AddExerciseMediaCommandValidator : AbstractValidator<AddExerciseMediaCommand>
{
    public AddExerciseMediaCommandValidator()
    {
        RuleFor(c => c.ExerciseId).NotEmpty();
        RuleFor(c => c.Kind).IsInEnum();
        RuleFor(c => c.Url).MaximumLength(2048);
        RuleFor(c => c.StorageKey).MaximumLength(1024);
        RuleFor(c => c.ContentType).MaximumLength(255);

        RuleFor(c => c)
            .Must(c => !string.IsNullOrWhiteSpace(c.StorageKey) || !string.IsNullOrWhiteSpace(c.Url))
            .WithMessage("Either StorageKey or Url must be provided.");
    }
}
