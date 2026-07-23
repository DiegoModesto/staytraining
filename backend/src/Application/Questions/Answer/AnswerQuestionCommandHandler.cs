using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Questions;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Questions.Answer;

public sealed class AnswerQuestionCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<AnswerQuestionCommand>
{
    public async Task<Result> Handle(AnswerQuestionCommand command, CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        Question? question = await dbContext.Questions
            .FirstOrDefaultAsync(
                q => q.Id == command.QuestionId && (tenantId == null || q.TenantId == tenantId),
                cancellationToken);

        if (question is null)
        {
            return Result.Failure(QuestionErrors.NotFound(command.QuestionId));
        }

        question.AnswerText = command.Answer;
        question.AnsweredByUserId = userContext.UserId;
        question.AnsweredByName = string.IsNullOrWhiteSpace(userContext.Name) ? "Professor" : userContext.Name;
        question.AnsweredAt = DateTimeOffset.UtcNow;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
