using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Exercises;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Exercises.GetById;

public sealed class GetExerciseByIdQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<GetExerciseByIdQuery, ExerciseResponse>
{
    public async Task<Result<ExerciseResponse>> Handle(
        GetExerciseByIdQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        ExerciseResponse? response = await dbContext.Exercises
            .Where(e => e.Id == query.Id
                && !e.IsDeleted
                && (tenantId == null || e.TenantId == tenantId))
            .Select(e => new ExerciseResponse(
                e.Id,
                e.Name,
                e.Description,
                e.ModalityId,
                e.Modality!.Name,
                e.PrimaryMuscleGroupId,
                e.SecondaryMuscleGroupIds,
                e.UsageExample,
                e.DefaultSets,
                e.DefaultReps,
                e.DefaultRestSeconds,
                e.IsAerobic,
                e.DefaultWorkSeconds,
                e.DefaultIntervalRestSeconds,
                e.DefaultRounds,
                e.Media.Select(m => new ExerciseMediaResponse(
                    m.Id, m.Kind, m.StorageKey, m.Url, m.ContentType, m.SizeBytes)).ToList()))
            .FirstOrDefaultAsync(cancellationToken);

        return response is null
            ? Result.Failure<ExerciseResponse>(ExerciseErrors.NotFound(query.Id))
            : response;
    }
}
