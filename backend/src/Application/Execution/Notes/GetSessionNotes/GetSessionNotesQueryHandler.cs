using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Execution.Notes.GetSessionNotes;

public sealed class GetSessionNotesQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<GetSessionNotesQuery, IReadOnlyCollection<ExerciseNoteResponse>>
{
    public async Task<Result<IReadOnlyCollection<ExerciseNoteResponse>>> Handle(
        GetSessionNotesQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        var session = await dbContext.WorkoutSessions
            .Where(s => s.Id == query.SessionId && !s.IsDeleted
                && (tenantId == null || s.TenantId == tenantId))
            .Select(s => new { s.Id, s.StartedAt })
            .FirstOrDefaultAsync(cancellationToken);

        if (session is null)
        {
            return new List<ExerciseNoteResponse>();
        }

        List<ExerciseNoteResponse> notes = await dbContext.ExerciseNotes
            .Where(n => n.WorkoutSessionId == session.Id)
            .Select(n => new ExerciseNoteResponse(
                n.Id, session.Id, session.StartedAt, n.WorkoutItemId, n.ExerciseId, n.LoadKg,
                n.PainFlag, n.PainNote, n.Comment, n.PerformedSets, n.PerformedReps, n.CreatedAt))
            .ToListAsync(cancellationToken);

        return notes;
    }
}
