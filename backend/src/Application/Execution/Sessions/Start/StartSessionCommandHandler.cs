using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Execution;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Execution.Sessions.Start;

public sealed class StartSessionCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<StartSessionCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        StartSessionCommand command,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to start a session.");

        bool workoutExists = await dbContext.Workouts
            .AnyAsync(w => w.Id == command.WorkoutId && !w.IsDeleted && w.TenantId == tenantId, cancellationToken);

        if (!workoutExists)
        {
            return Result.Failure<Guid>(WorkoutErrors.NotFound(command.WorkoutId));
        }

        var session = new WorkoutSession
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            StudentId = userContext.UserId,
            WorkoutId = command.WorkoutId,
            StartedAt = DateTimeOffset.UtcNow,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        dbContext.WorkoutSessions.Add(session);
        await dbContext.SaveChangesAsync(cancellationToken);

        return session.Id;
    }
}
