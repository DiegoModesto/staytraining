using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Workouts.Workouts.AddItem;

public sealed class AddWorkoutItemCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<AddWorkoutItemCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        AddWorkoutItemCommand command,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        Workout? workout = await dbContext.Workouts
            .Include(w => w.Items)
            .FirstOrDefaultAsync(
                w => w.Id == command.WorkoutId && !w.IsDeleted
                    && (tenantId == null || w.TenantId == tenantId),
                cancellationToken);

        if (workout is null)
        {
            return Result.Failure<Guid>(WorkoutErrors.NotFound(command.WorkoutId));
        }

        WorkoutItemInput input = command.Item;
        int nextOrder = workout.Items.Count == 0 ? 1 : workout.Items.Max(i => i.Order) + 1;
        int order = input.Order > 0 ? input.Order : nextOrder;

        var item = new WorkoutItem
        {
            Id = Guid.NewGuid(),
            WorkoutId = workout.Id,
            ExerciseId = input.ExerciseId,
            Order = order,
            SectionLabel = input.SectionLabel,
            Sets = input.Sets,
            Reps = input.Reps,
            RestSeconds = input.RestSeconds,
            DurationSeconds = input.DurationSeconds,
            WorkSeconds = input.WorkSeconds,
            IntervalRestSeconds = input.IntervalRestSeconds,
            Rounds = input.Rounds,
            ProfessorComment = input.ProfessorComment,
        };

        dbContext.WorkoutItems.Add(item);
        await dbContext.SaveChangesAsync(cancellationToken);

        return item.Id;
    }
}
