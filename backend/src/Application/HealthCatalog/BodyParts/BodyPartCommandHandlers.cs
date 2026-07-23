using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.HealthCatalog;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.HealthCatalog.BodyParts;

public sealed class CreateBodyPartCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<CreateBodyPartCommand, Guid>
{
    public async Task<Result<Guid>> Handle(CreateBodyPartCommand command, CancellationToken cancellationToken)
    {
        string name = command.Name.Trim();
        if (name.Length == 0)
        {
            return Result.Failure<Guid>(Error.Validation("BodyPart.NameRequired", "Name is required."));
        }

        int nextOrder = await dbContext.BodyParts.CountAsync(cancellationToken);
        var bodyPart = new BodyPart
        {
            Id = Guid.NewGuid(),
            Name = name,
            SortOrder = nextOrder,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        dbContext.BodyParts.Add(bodyPart);
        await dbContext.SaveChangesAsync(cancellationToken);
        return bodyPart.Id;
    }
}

public sealed class UpdateBodyPartCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<UpdateBodyPartCommand>
{
    public async Task<Result> Handle(UpdateBodyPartCommand command, CancellationToken cancellationToken)
    {
        BodyPart? bodyPart = await dbContext.BodyParts
            .FirstOrDefaultAsync(b => b.Id == command.Id, cancellationToken);
        if (bodyPart is null)
        {
            return Result.Failure(HealthCatalogErrors.BodyPartNotFound(command.Id));
        }

        string name = command.Name.Trim();
        if (name.Length == 0)
        {
            return Result.Failure(Error.Validation("BodyPart.NameRequired", "Name is required."));
        }

        bodyPart.Name = name;
        await dbContext.SaveChangesAsync(cancellationToken);
        return Result.Success();
    }
}

public sealed class DeleteBodyPartCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<DeleteBodyPartCommand>
{
    public async Task<Result> Handle(DeleteBodyPartCommand command, CancellationToken cancellationToken)
    {
        BodyPart? bodyPart = await dbContext.BodyParts
            .Include(b => b.ProblemTypes)
            .FirstOrDefaultAsync(b => b.Id == command.Id, cancellationToken);
        if (bodyPart is null)
        {
            return Result.Failure(HealthCatalogErrors.BodyPartNotFound(command.Id));
        }

        bool inUse = await dbContext.HealthApportments
            .AnyAsync(a => a.BodyPartId == command.Id, cancellationToken);
        if (inUse)
        {
            return Result.Failure(HealthCatalogErrors.BodyPartInUse(command.Id));
        }

        DateTimeOffset now = DateTimeOffset.UtcNow;
        bodyPart.IsDeleted = true;
        bodyPart.DeletedAt = now;
        foreach (ProblemType problemType in bodyPart.ProblemTypes)
        {
            problemType.IsDeleted = true;
            problemType.DeletedAt = now;
        }

        await dbContext.SaveChangesAsync(cancellationToken);
        return Result.Success();
    }
}
