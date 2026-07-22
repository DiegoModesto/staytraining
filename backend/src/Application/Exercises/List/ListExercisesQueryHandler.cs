using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Exercises.List;

public sealed class ListExercisesQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<ListExercisesQuery, IReadOnlyCollection<ExerciseListItemResponse>>
{
    public async Task<Result<IReadOnlyCollection<ExerciseListItemResponse>>> Handle(
        ListExercisesQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        List<ExerciseListItemResponse> items = await dbContext.Exercises
            .Where(e => !e.IsDeleted
                && (tenantId == null || e.TenantId == tenantId)
                && (query.Category == null || e.Category == query.Category))
            .OrderBy(e => e.Name)
            .Select(e => new ExerciseListItemResponse(
                e.Id, e.Name, e.Category, e.PrimaryMuscleGroupId, e.IsAerobic))
            .ToListAsync(cancellationToken);

        return items;
    }
}
