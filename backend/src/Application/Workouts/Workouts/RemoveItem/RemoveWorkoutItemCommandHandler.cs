using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Workouts.Workouts.RemoveItem;

public sealed class RemoveWorkoutItemCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<RemoveWorkoutItemCommand>
{
    public async Task<Result> Handle(
        RemoveWorkoutItemCommand command,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        Workout? workout = await dbContext.Workouts
            .Include(w => w.Items)
            .FirstOrDefaultAsync(
                w => w.Id == command.WorkoutId && !w.IsDeleted
                    && (tenantId == null || w.TenantId == tenantId),
                cancellationToken);

        if (workout is null)
        {
            return Result.Failure(WorkoutErrors.NotFound(command.WorkoutId));
        }

        WorkoutItem? item = workout.Items.FirstOrDefault(i => i.Id == command.ItemId);
        if (item is null)
        {
            return Result.Failure(WorkoutErrors.ItemNotFound(command.ItemId));
        }

        dbContext.WorkoutItems.Remove(item);
        await dbContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
