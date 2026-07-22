using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Execution;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Execution.Sessions.Complete;

public sealed class CompleteSessionCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<CompleteSessionCommand>
{
    public async Task<Result> Handle(
        CompleteSessionCommand command,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        WorkoutSession? session = await dbContext.WorkoutSessions
            .FirstOrDefaultAsync(
                s => s.Id == command.SessionId && !s.IsDeleted
                    && s.StudentId == userContext.UserId
                    && (tenantId == null || s.TenantId == tenantId),
                cancellationToken);

        if (session is null)
        {
            return Result.Failure(WorkoutSessionErrors.NotFound(command.SessionId));
        }

        if (session.CompletedAt is not null)
        {
            return Result.Failure(WorkoutSessionErrors.AlreadyCompleted);
        }

        session.CompletedAt = DateTimeOffset.UtcNow;
        session.CompletionRating = command.CompletionRating;
        session.OverallComment = command.OverallComment;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
