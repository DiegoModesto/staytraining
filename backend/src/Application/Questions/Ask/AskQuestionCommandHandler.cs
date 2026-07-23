using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Questions;
using SharedKernel;

namespace Application.Questions.Ask;

public sealed class AskQuestionCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<AskQuestionCommand, Guid>
{
    public async Task<Result<Guid>> Handle(AskQuestionCommand command, CancellationToken cancellationToken)
    {
        if (command.WorkoutId is null && command.ExerciseId is null)
        {
            return Result.Failure<Guid>(QuestionErrors.NoTarget);
        }

        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to ask a question.");

        var question = new Question
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            StudentId = userContext.UserId,
            StudentName = string.IsNullOrWhiteSpace(userContext.Name) ? "Aluno" : userContext.Name!,
            WorkoutId = command.WorkoutId,
            ExerciseId = command.ExerciseId,
            Text = command.Text,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        dbContext.Questions.Add(question);
        await dbContext.SaveChangesAsync(cancellationToken);

        return question.Id;
    }
}
