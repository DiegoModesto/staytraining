using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Workouts.Workouts.Delete;

public sealed class DeleteWorkoutCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<DeleteWorkoutCommand>
{
    public async Task<Result> Handle(
        DeleteWorkoutCommand command,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        Workout? workout = await dbContext.Workouts
            .FirstOrDefaultAsync(
                w => w.Id == command.WorkoutId && !w.IsDeleted
                    && (tenantId == null || w.TenantId == tenantId),
                cancellationToken);

        if (workout is null
            || (!userContext.HasPermission("student.manage") && workout.OwnerStudentId != userContext.UserId))
        {
            return Result.Failure(WorkoutErrors.NotFound(command.WorkoutId));
        }

        // Soft delete — every read path already filters !IsDeleted.
        workout.IsDeleted = true;
        workout.DeletedAt = DateTimeOffset.UtcNow;
        await dbContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
