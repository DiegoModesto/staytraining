using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.MuscleGroups.List;

public sealed class ListMuscleGroupsQueryHandler(IApplicationDbContext dbContext)
    : IQueryHandler<ListMuscleGroupsQuery, IReadOnlyCollection<MuscleGroupResponse>>
{
    public async Task<Result<IReadOnlyCollection<MuscleGroupResponse>>> Handle(
        ListMuscleGroupsQuery query,
        CancellationToken cancellationToken)
    {
        List<MuscleGroupResponse> items = await dbContext.MuscleGroups
            .Where(m => !m.IsDeleted)
            .OrderBy(m => m.BodyRegion).ThenBy(m => m.Name)
            .Select(m => new MuscleGroupResponse(m.Id, m.Name, m.BodyRegion))
            .ToListAsync(cancellationToken);

        return items;
    }
}
