using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Modalities;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Modalities.Update;

public sealed class UpdateModalityCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<UpdateModalityCommand>
{
    public async Task<Result> Handle(
        UpdateModalityCommand command,
        CancellationToken cancellationToken)
    {
        Modality? modality = await dbContext.Modalities
            .FirstOrDefaultAsync(m => m.Id == command.Id, cancellationToken);
        if (modality is null)
        {
            return Result.Failure(ModalityErrors.NotFound(command.Id));
        }

        string name = command.Name.Trim();

        bool nameTaken = await dbContext.Modalities
            .AnyAsync(m => m.Id != command.Id && m.Name.ToLower() == name.ToLower(), cancellationToken);
        if (nameTaken)
        {
            return Result.Failure(ModalityErrors.NameNotUnique(name));
        }

        modality.Name = name;
        modality.ColorHex = command.ColorHex;
        modality.IsIntervalBased = command.IsIntervalBased;
        modality.SortOrder = command.SortOrder;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
