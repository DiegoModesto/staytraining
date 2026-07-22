using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Workouts.Workouts.List;

public sealed class ListWorkoutsQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<ListWorkoutsQuery, IReadOnlyCollection<WorkoutListItemResponse>>
{
    public async Task<Result<IReadOnlyCollection<WorkoutListItemResponse>>> Handle(
        ListWorkoutsQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        List<WorkoutListItemResponse> items = await dbContext.Workouts
            .Where(w => !w.IsDeleted
                && (tenantId == null || w.TenantId == tenantId)
                && (query.OwnerStudentId == null || w.OwnerStudentId == query.OwnerStudentId))
            .OrderBy(w => w.Name)
            .Select(w => new WorkoutListItemResponse(w.Id, w.Name, w.Category, w.Items.Count))
            .ToListAsync(cancellationToken);

        return items;
    }
}
