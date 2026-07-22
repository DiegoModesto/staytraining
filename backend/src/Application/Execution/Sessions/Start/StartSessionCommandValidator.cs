using FluentValidation;

namespace Application.Execution.Sessions.Start;

internal sealed class StartSessionCommandValidator : AbstractValidator<StartSessionCommand>
{
    public StartSessionCommandValidator() => RuleFor(c => c.WorkoutId).NotEmpty();
}
