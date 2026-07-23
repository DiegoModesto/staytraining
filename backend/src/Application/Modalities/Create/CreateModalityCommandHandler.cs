using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Modalities;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Modalities.Create;

public sealed class CreateModalityCommandHandler(IApplicationDbContext dbContext)
    : ICommandHandler<CreateModalityCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        CreateModalityCommand command,
        CancellationToken cancellationToken)
    {
        string name = command.Name.Trim();

        bool nameTaken = await dbContext.Modalities
            .AnyAsync(m => m.Name.ToLower() == name.ToLower(), cancellationToken);
        if (nameTaken)
        {
            return Result.Failure<Guid>(ModalityErrors.NameNotUnique(name));
        }

        var modality = new Modality
        {
            Id = Guid.NewGuid(),
            Name = name,
            ColorHex = command.ColorHex,
            IsIntervalBased = command.IsIntervalBased,
            SortOrder = command.SortOrder,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        dbContext.Modalities.Add(modality);
        await dbContext.SaveChangesAsync(cancellationToken);

        return modality.Id;
    }
}
