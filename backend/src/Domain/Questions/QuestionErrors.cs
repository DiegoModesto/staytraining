using SharedKernel;

namespace Domain.Questions;

public static class QuestionErrors
{
    public static Error NotFound(Guid id) =>
        Error.NotFound("Question.NotFound", $"Question with id '{id}' was not found.");

    public static readonly Error NoTarget = Error.Validation(
        "Question.NoTarget", "A question must reference a workout or an exercise.");
}
