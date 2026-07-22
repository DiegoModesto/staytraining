using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Execution;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Sync.Push;

public sealed class PushSessionsCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<PushSessionsCommand, SyncPushResult>
{
    public async Task<Result<SyncPushResult>> Handle(
        PushSessionsCommand command,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to push sessions.");
        Guid studentId = userContext.UserId;

        var incomingIds = command.Sessions.Select(s => s.Id).ToList();

        HashSet<Guid> existingIds = (await dbContext.WorkoutSessions
                .Where(s => incomingIds.Contains(s.Id))
                .Select(s => s.Id)
                .ToListAsync(cancellationToken))
            .ToHashSet();

        int inserted = 0;

        foreach (SessionPushInput input in command.Sessions)
        {
            if (existingIds.Contains(input.Id))
            {
                continue; // idempotent: last-write-wins keeps the first server copy
            }

            var session = new WorkoutSession
            {
                Id = input.Id,
                TenantId = tenantId,
                StudentId = studentId,
                WorkoutId = input.WorkoutId,
                StartedAt = input.StartedAt,
                CompletedAt = input.CompletedAt,
                CompletionRating = input.CompletionRating,
                OverallComment = input.OverallComment,
                CreatedAt = DateTimeOffset.UtcNow,
            };

            foreach (NotePushInput note in input.Notes)
            {
                session.Notes.Add(new ExerciseNote
                {
                    Id = note.Id == Guid.Empty ? Guid.NewGuid() : note.Id,
                    WorkoutSessionId = session.Id,
                    WorkoutItemId = note.WorkoutItemId,
                    ExerciseId = note.ExerciseId,
                    LoadKg = note.LoadKg,
                    PainFlag = note.PainFlag,
                    PainNote = note.PainNote,
                    Comment = note.Comment,
                    PerformedSets = note.PerformedSets,
                    PerformedReps = note.PerformedReps,
                    CreatedAt = note.CreatedAt == default ? DateTimeOffset.UtcNow : note.CreatedAt,
                });
            }

            dbContext.WorkoutSessions.Add(session);
            inserted++;
        }

        if (inserted > 0)
        {
            await dbContext.SaveChangesAsync(cancellationToken);
        }

        return new SyncPushResult(inserted, command.Sessions.Count - inserted);
    }
}
