using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Workouts.Templates.List;

public sealed class ListWorkoutTemplatesQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<ListWorkoutTemplatesQuery, IReadOnlyCollection<WorkoutTemplateListItemResponse>>
{
    public async Task<Result<IReadOnlyCollection<WorkoutTemplateListItemResponse>>> Handle(
        ListWorkoutTemplatesQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        List<WorkoutTemplateListItemResponse> items = await dbContext.WorkoutTemplates
            .Where(t => !t.IsDeleted
                && (tenantId == null || t.TenantId == tenantId)
                && (query.OnlySystemDefaults == null || t.IsSystemDefault == query.OnlySystemDefaults))
            .OrderBy(t => t.Name)
            .Select(t => new WorkoutTemplateListItemResponse(
                t.Id, t.Name, t.ModalityId, t.Modality != null ? t.Modality.Name : null,
                t.IsSystemDefault, t.Items.Count))
            .ToListAsync(cancellationToken);

        return items;
    }
}
