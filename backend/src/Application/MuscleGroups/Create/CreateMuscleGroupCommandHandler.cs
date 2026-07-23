using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.MuscleGroups;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.MuscleGroups.Create;

public sealed class CreateMuscleGroupCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<CreateMuscleGroupCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        CreateMuscleGroupCommand command,
        CancellationToken cancellationToken)
    {
        string name = command.Name.Trim();

        bool nameTaken = await dbContext.MuscleGroups
            .AnyAsync(m => m.Name.ToLower() == name.ToLower(), cancellationToken);
        if (nameTaken)
        {
            return Result.Failure<Guid>(MuscleGroupErrors.NameNotUnique(name));
        }

        var muscle = new MuscleGroup
        {
            Id = Guid.NewGuid(),
            Name = name,
            BodyRegion = command.BodyRegion.Trim(),
            CreatedAt = DateTimeOffset.UtcNow,
        };

        dbContext.MuscleGroups.Add(muscle);
        await dbContext.SaveChangesAsync(cancellationToken);

        return muscle.Id;
    }
}
