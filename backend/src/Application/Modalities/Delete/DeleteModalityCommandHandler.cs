using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Modalities;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Modalities.Delete;

public sealed class DeleteModalityCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<DeleteModalityCommand>
{
    public async Task<Result> Handle(
        DeleteModalityCommand command,
        CancellationToken cancellationToken)
    {
        Modality? modality = await dbContext.Modalities
            .FirstOrDefaultAsync(m => m.Id == command.Id, cancellationToken);
        if (modality is null)
        {
            return Result.Failure(ModalityErrors.NotFound(command.Id));
        }

        bool inUse = await dbContext.Exercises
            .AnyAsync(e => e.ModalityId == command.Id, cancellationToken);
        if (inUse)
        {
            return Result.Failure(ModalityErrors.InUse(command.Id));
        }

        modality.IsDeleted = true;
        modality.DeletedAt = DateTimeOffset.UtcNow;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
