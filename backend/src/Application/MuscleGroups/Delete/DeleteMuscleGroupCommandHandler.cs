using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.MuscleGroups;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.MuscleGroups.Delete;

public sealed class DeleteMuscleGroupCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<DeleteMuscleGroupCommand>
{
    public async Task<Result> Handle(
        DeleteMuscleGroupCommand command,
        CancellationToken cancellationToken)
    {
        MuscleGroup? muscle = await dbContext.MuscleGroups
            .FirstOrDefaultAsync(m => m.Id == command.Id, cancellationToken);
        if (muscle is null)
        {
            return Result.Failure(MuscleGroupErrors.NotFound(command.Id));
        }

        // Block deletion while any exercise still references the muscle (as primary or secondary).
        bool inUse = await dbContext.Exercises
            .AnyAsync(e => e.PrimaryMuscleGroupId == command.Id
                || e.SecondaryMuscleGroupIds.Contains(command.Id), cancellationToken);
        if (inUse)
        {
            return Result.Failure(MuscleGroupErrors.InUse(command.Id));
        }

        muscle.IsDeleted = true;
        muscle.DeletedAt = DateTimeOffset.UtcNow;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
