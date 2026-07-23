using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.MuscleGroups;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.MuscleGroups.Update;

public sealed class UpdateMuscleGroupCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<UpdateMuscleGroupCommand>
{
    public async Task<Result> Handle(
        UpdateMuscleGroupCommand command,
        CancellationToken cancellationToken)
    {
        MuscleGroup? muscle = await dbContext.MuscleGroups
            .FirstOrDefaultAsync(m => m.Id == command.Id, cancellationToken);
        if (muscle is null)
        {
            return Result.Failure(MuscleGroupErrors.NotFound(command.Id));
        }

        string name = command.Name.Trim();

        bool nameTaken = await dbContext.MuscleGroups
            .AnyAsync(m => m.Id != command.Id && m.Name.ToLower() == name.ToLower(), cancellationToken);
        if (nameTaken)
        {
            return Result.Failure(MuscleGroupErrors.NameNotUnique(name));
        }

        muscle.Name = name;
        muscle.BodyRegion = command.BodyRegion.Trim();

        await dbContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
