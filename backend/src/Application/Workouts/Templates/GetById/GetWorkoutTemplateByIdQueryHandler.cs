using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Workouts.Templates.GetById;

public sealed class GetWorkoutTemplateByIdQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<GetWorkoutTemplateByIdQuery, WorkoutTemplateResponse>
{
    public async Task<Result<WorkoutTemplateResponse>> Handle(
        GetWorkoutTemplateByIdQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        WorkoutTemplateResponse? response = await dbContext.WorkoutTemplates
            .Where(t => t.Id == query.Id
                && !t.IsDeleted
                && (tenantId == null || t.TenantId == tenantId))
            .Select(t => new WorkoutTemplateResponse(
                t.Id,
                t.Name,
                t.Description,
                t.Category,
                t.IsSystemDefault,
                t.CreatorNotes,
                t.Items
                    .OrderBy(i => i.Order)
                    .Select(i => new TemplateItemResponse(
                        i.Id, i.ExerciseId, i.Order, i.SectionLabel, i.Sets, i.Reps, i.RestSeconds,
                        i.DurationSeconds, i.WorkSeconds, i.IntervalRestSeconds, i.Rounds, i.CreatorNotes))
                    .ToList()))
            .FirstOrDefaultAsync(cancellationToken);

        return response is null
            ? Result.Failure<WorkoutTemplateResponse>(WorkoutTemplateErrors.NotFound(query.Id))
            : response;
    }
}
