using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Students.EditLogs;

public sealed record ListStudentEditLogsQuery(Guid StudentProfileId)
    : IQuery<IReadOnlyCollection<StudentEditLogResponse>>;

public sealed class ListStudentEditLogsQueryHandler(IApplicationDbContext dbContext)
    : IQueryHandler<ListStudentEditLogsQuery, IReadOnlyCollection<StudentEditLogResponse>>
{
    public async Task<Result<IReadOnlyCollection<StudentEditLogResponse>>> Handle(
        ListStudentEditLogsQuery query,
        CancellationToken cancellationToken)
    {
        List<StudentEditLogResponse> items = await dbContext.StudentEditLogs
            .Where(l => l.StudentProfileId == query.StudentProfileId)
            .OrderByDescending(l => l.CreatedAt)
            .Select(l => new StudentEditLogResponse(
                l.Id, l.EditorUserId, l.EditorName, l.Action, l.Detail, l.CreatedAt))
            .ToListAsync(cancellationToken);

        return items;
    }
}
