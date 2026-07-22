using FluentValidation;

namespace Application.Execution.Sessions.Complete;

internal sealed class CompleteSessionCommandValidator : AbstractValidator<CompleteSessionCommand>
{
    public CompleteSessionCommandValidator()
    {
        RuleFor(c => c.SessionId).NotEmpty();
        RuleFor(c => c.CompletionRating).InclusiveBetween(0, 5).When(c => c.CompletionRating.HasValue);
        RuleFor(c => c.OverallComment).MaximumLength(4000);
    }
}
