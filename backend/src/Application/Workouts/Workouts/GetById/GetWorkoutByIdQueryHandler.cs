using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Workouts.Workouts.GetById;

public sealed class GetWorkoutByIdQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<GetWorkoutByIdQuery, WorkoutResponse>
{
    public async Task<Result<WorkoutResponse>> Handle(
        GetWorkoutByIdQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        WorkoutResponse? response = await dbContext.Workouts
            .Where(w => w.Id == query.Id
                && !w.IsDeleted
                && (tenantId == null || w.TenantId == tenantId))
            .Select(w => new WorkoutResponse(
                w.Id,
                w.OwnerStudentId,
                w.SourceTemplateId,
                w.Name,
                w.Description,
                w.ModalityId,
                w.Modality != null ? w.Modality.Name : null,
                w.Items
                    .OrderBy(i => i.Order)
                    .Select(i => new WorkoutItemResponse(
                        i.Id, i.ExerciseId, i.Order, i.SectionLabel, i.Sets, i.Reps, i.RestSeconds,
                        i.DurationSeconds, i.WorkSeconds, i.IntervalRestSeconds, i.Rounds, i.ProfessorComment))
                    .ToList()))
            .FirstOrDefaultAsync(cancellationToken);

        return response is null
            ? Result.Failure<WorkoutResponse>(WorkoutErrors.NotFound(query.Id))
            : response;
    }
}
