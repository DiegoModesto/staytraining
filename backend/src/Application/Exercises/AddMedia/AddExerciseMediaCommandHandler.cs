using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Exercises;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Exercises.AddMedia;

public sealed class AddExerciseMediaCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<AddExerciseMediaCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        AddExerciseMediaCommand command,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        bool exerciseExists = await dbContext.Exercises
            .AnyAsync(e => e.Id == command.ExerciseId
                && !e.IsDeleted
                && (tenantId == null || e.TenantId == tenantId), cancellationToken);

        if (!exerciseExists)
        {
            return Result.Failure<Guid>(ExerciseErrors.NotFound(command.ExerciseId));
        }

        var media = new ExerciseMedia
        {
            Id = Guid.NewGuid(),
            ExerciseId = command.ExerciseId,
            Kind = command.Kind,
            StorageKey = command.StorageKey,
            Url = command.Url,
            ContentType = command.ContentType,
            SizeBytes = command.SizeBytes,
        };

        dbContext.ExerciseMedia.Add(media);
        await dbContext.SaveChangesAsync(cancellationToken);

        return media.Id;
    }
}
