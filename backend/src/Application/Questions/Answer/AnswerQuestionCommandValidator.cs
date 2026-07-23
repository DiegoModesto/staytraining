using FluentValidation;

namespace Application.Questions.Answer;

internal sealed class AnswerQuestionCommandValidator : AbstractValidator<AnswerQuestionCommand>
{
    public AnswerQuestionCommandValidator()
    {
        RuleFor(c => c.QuestionId).NotEmpty();
        RuleFor(c => c.Answer).NotEmpty().MaximumLength(4000);
    }
}
