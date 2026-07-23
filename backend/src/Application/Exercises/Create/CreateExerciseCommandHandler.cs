using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Exercises;
using Domain.Modalities;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Exercises.Create;

public sealed class CreateExerciseCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<CreateExerciseCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        CreateExerciseCommand command,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to create an Exercise.");

        bool modalityExists = await dbContext.Modalities
            .AnyAsync(m => m.Id == command.ModalityId, cancellationToken);
        if (!modalityExists)
        {
            return Result.Failure<Guid>(ModalityErrors.NotFound(command.ModalityId));
        }

        var exercise = new Exercise
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            Name = command.Name,
            Description = command.Description,
            ModalityId = command.ModalityId,
            PrimaryMuscleGroupId = command.PrimaryMuscleGroupId,
            SecondaryMuscleGroupIds = command.SecondaryMuscleGroupIds?.ToList() ?? [],
            UsageExample = command.UsageExample,
            DefaultSets = command.DefaultSets,
            DefaultReps = command.DefaultReps,
            DefaultRestSeconds = command.DefaultRestSeconds,
            IsAerobic = command.IsAerobic,
            DefaultWorkSeconds = command.DefaultWorkSeconds,
            DefaultIntervalRestSeconds = command.DefaultIntervalRestSeconds,
            DefaultRounds = command.DefaultRounds,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        if (command.Media is not null)
        {
            foreach (ExerciseMediaInput media in command.Media)
            {
                exercise.Media.Add(new ExerciseMedia
                {
                    Id = Guid.NewGuid(),
                    ExerciseId = exercise.Id,
                    Kind = media.Kind,
                    StorageKey = media.StorageKey,
                    Url = media.Url,
                    ContentType = media.ContentType,
                    SizeBytes = media.SizeBytes,
                });
            }
        }

        dbContext.Exercises.Add(exercise);
        await dbContext.SaveChangesAsync(cancellationToken);

        return exercise.Id;
    }
}
