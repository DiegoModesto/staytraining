using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.HealthCatalog;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.HealthCatalog.ProblemTypes;

public sealed class CreateProblemTypeCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<CreateProblemTypeCommand, Guid>
{
    public async Task<Result<Guid>> Handle(CreateProblemTypeCommand command, CancellationToken cancellationToken)
    {
        string name = command.Name.Trim();
        if (name.Length == 0)
        {
            return Result.Failure<Guid>(Error.Validation("ProblemType.NameRequired", "Name is required."));
        }

        bool bodyPartExists = await dbContext.BodyParts.AnyAsync(b => b.Id == command.BodyPartId, cancellationToken);
        if (!bodyPartExists)
        {
            return Result.Failure<Guid>(HealthCatalogErrors.BodyPartNotFound(command.BodyPartId));
        }

        int nextOrder = await dbContext.ProblemTypes.CountAsync(p => p.BodyPartId == command.BodyPartId, cancellationToken);
        var problemType = new ProblemType
        {
            Id = Guid.NewGuid(),
            BodyPartId = command.BodyPartId,
            Name = name,
            SortOrder = nextOrder,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        dbContext.ProblemTypes.Add(problemType);
        await dbContext.SaveChangesAsync(cancellationToken);
        return problemType.Id;
    }
}

public sealed class UpdateProblemTypeCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<UpdateProblemTypeCommand>
{
    public async Task<Result> Handle(UpdateProblemTypeCommand command, CancellationToken cancellationToken)
    {
        ProblemType? problemType = await dbContext.ProblemTypes
            .FirstOrDefaultAsync(p => p.Id == command.Id, cancellationToken);
        if (problemType is null)
        {
            return Result.Failure(HealthCatalogErrors.ProblemTypeNotFound(command.Id));
        }

        string name = command.Name.Trim();
        if (name.Length == 0)
        {
            return Result.Failure(Error.Validation("ProblemType.NameRequired", "Name is required."));
        }

        problemType.Name = name;
        await dbContext.SaveChangesAsync(cancellationToken);
        return Result.Success();
    }
}

public sealed class DeleteProblemTypeCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<DeleteProblemTypeCommand>
{
    public async Task<Result> Handle(DeleteProblemTypeCommand command, CancellationToken cancellationToken)
    {
        ProblemType? problemType = await dbContext.ProblemTypes
            .FirstOrDefaultAsync(p => p.Id == command.Id, cancellationToken);
        if (problemType is null)
        {
            return Result.Failure(HealthCatalogErrors.ProblemTypeNotFound(command.Id));
        }

        bool inUse = await dbContext.HealthApportments
            .AnyAsync(a => a.ProblemTypeId == command.Id, cancellationToken);
        if (inUse)
        {
            return Result.Failure(HealthCatalogErrors.ProblemTypeInUse(command.Id));
        }

        problemType.IsDeleted = true;
        problemType.DeletedAt = DateTimeOffset.UtcNow;
        await dbContext.SaveChangesAsync(cancellationToken);
        return Result.Success();
    }
}
