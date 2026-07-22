using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Execution;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Execution.Sessions.UpsertNote;

public sealed class UpsertExerciseNoteCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<UpsertExerciseNoteCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        UpsertExerciseNoteCommand command,
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
            return Result.Failure<Guid>(WorkoutSessionErrors.NotFound(command.SessionId));
        }

        ExerciseNote? note = await dbContext.ExerciseNotes
            .FirstOrDefaultAsync(
                n => n.WorkoutSessionId == command.SessionId && n.WorkoutItemId == command.WorkoutItemId,
                cancellationToken);

        if (note is null)
        {
            note = new ExerciseNote
            {
                Id = Guid.NewGuid(),
                WorkoutSessionId = command.SessionId,
                WorkoutItemId = command.WorkoutItemId,
                ExerciseId = command.ExerciseId,
                CreatedAt = DateTimeOffset.UtcNow,
            };
            dbContext.ExerciseNotes.Add(note);
        }
        else
        {
            note.UpdatedAt = DateTimeOffset.UtcNow;
        }

        note.LoadKg = command.LoadKg;
        note.PainFlag = command.PainFlag;
        note.PainNote = command.PainNote;
        note.Comment = command.Comment;
        note.PerformedSets = command.PerformedSets;
        note.PerformedReps = command.PerformedReps;

        await dbContext.SaveChangesAsync(cancellationToken);

        return note.Id;
    }
}
