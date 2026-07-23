using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Workouts.Workouts.Rename;

public sealed class RenameWorkoutCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<RenameWorkoutCommand>
{
    public async Task<Result> Handle(
        RenameWorkoutCommand command,
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

        workout.Name = command.Name.Trim();
        await dbContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
