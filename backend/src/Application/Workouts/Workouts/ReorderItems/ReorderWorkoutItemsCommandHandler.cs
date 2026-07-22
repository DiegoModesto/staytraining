using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Workouts.Workouts.ReorderItems;

public sealed class ReorderWorkoutItemsCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<ReorderWorkoutItemsCommand>
{
    public async Task<Result> Handle(
        ReorderWorkoutItemsCommand command,
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

        for (int index = 0; index < command.OrderedItemIds.Count; index++)
        {
            Guid itemId = command.OrderedItemIds[index];
            WorkoutItem? item = workout.Items.FirstOrDefault(i => i.Id == itemId);
            if (item is null)
            {
                return Result.Failure(WorkoutErrors.ItemNotFound(itemId));
            }

            item.Order = index + 1;
        }

        await dbContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
