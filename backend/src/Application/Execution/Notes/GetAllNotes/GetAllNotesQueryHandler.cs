using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Execution.Notes.GetAllNotes;

public sealed class GetAllNotesQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<GetAllNotesQuery, IReadOnlyCollection<ExerciseNoteResponse>>
{
    public async Task<Result<IReadOnlyCollection<ExerciseNoteResponse>>> Handle(
        GetAllNotesQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;
        Guid studentId = query.StudentId ?? userContext.UserId;

        var sessions = await dbContext.WorkoutSessions
            .Where(s => !s.IsDeleted
                && s.StudentId == studentId
                && (tenantId == null || s.TenantId == tenantId))
            .Select(s => new { s.Id, s.StartedAt })
            .ToListAsync(cancellationToken);

        var startedAtById = sessions.ToDictionary(s => s.Id, s => s.StartedAt);
        List<Guid> sessionIds = [.. startedAtById.Keys];

        List<Domain.Execution.ExerciseNote> rows = await dbContext.ExerciseNotes
            .Where(n => sessionIds.Contains(n.WorkoutSessionId)
                && (query.ExerciseId == null || n.ExerciseId == query.ExerciseId))
            .ToListAsync(cancellationToken);

        return rows
            .Select(n => new ExerciseNoteResponse(
                n.Id, n.WorkoutSessionId, startedAtById[n.WorkoutSessionId], n.WorkoutItemId, n.ExerciseId,
                n.LoadKg, n.PainFlag, n.PainNote, n.Comment, n.PerformedSets, n.PerformedReps, n.CreatedAt))
            .OrderByDescending(r => r.SessionDate)
            .ToList();
    }
}
