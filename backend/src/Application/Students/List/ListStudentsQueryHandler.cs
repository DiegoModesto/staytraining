using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Students.List;

public sealed class ListStudentsQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<ListStudentsQuery, IReadOnlyCollection<StudentListItemResponse>>
{
    public async Task<Result<IReadOnlyCollection<StudentListItemResponse>>> Handle(
        ListStudentsQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        List<StudentListItemResponse> items = await dbContext.StudentProfiles
            .Where(s => !s.IsDeleted && (tenantId == null || s.TenantId == tenantId))
            .OrderBy(s => s.FullName)
            .Select(s => new StudentListItemResponse(s.Id, s.UserId, s.FullName, s.Email))
            .ToListAsync(cancellationToken);

        return items;
    }
}
