using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Students.ListNotes;

public sealed class ListStudentNotesQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<ListStudentNotesQuery, IReadOnlyCollection<StudentNoteResponse>>
{
    public async Task<Result<IReadOnlyCollection<StudentNoteResponse>>> Handle(
        ListStudentNotesQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        List<StudentNoteResponse> notes = await dbContext.StudentNotes
            .Where(n => n.StudentProfileId == query.StudentProfileId)
            .Where(n => dbContext.StudentProfiles.Any(s =>
                s.Id == n.StudentProfileId && !s.IsDeleted && (tenantId == null || s.TenantId == tenantId)))
            .OrderByDescending(n => n.CreatedAt)
            .Select(n => new StudentNoteResponse(n.Id, n.WorkoutId, n.AuthorUserId, n.AuthorName, n.Content, n.CreatedAt))
            .ToListAsync(cancellationToken);

        return notes;
    }
}
