using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Workouts;
using SharedKernel;

namespace Application.Workouts.Workouts.Create;

public sealed class CreateWorkoutCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<CreateWorkoutCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        CreateWorkoutCommand command,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to create a Workout.");

        Guid ownerStudentId = command.OwnerStudentId == Guid.Empty
            ? userContext.UserId
            : command.OwnerStudentId;

        var workout = new Workout
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            OwnerStudentId = ownerStudentId,
            Name = command.Name,
            Description = command.Description,
            Category = command.Category,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        foreach (WorkoutItemInput item in command.Items)
        {
            workout.Items.Add(new WorkoutItem
            {
                Id = Guid.NewGuid(),
                WorkoutId = workout.Id,
                ExerciseId = item.ExerciseId,
                Order = item.Order,
                SectionLabel = item.SectionLabel,
                Sets = item.Sets,
                Reps = item.Reps,
                RestSeconds = item.RestSeconds,
                DurationSeconds = item.DurationSeconds,
                WorkSeconds = item.WorkSeconds,
                IntervalRestSeconds = item.IntervalRestSeconds,
                Rounds = item.Rounds,
                ProfessorComment = item.ProfessorComment,
            });
        }

        dbContext.Workouts.Add(workout);
        await dbContext.SaveChangesAsync(cancellationToken);

        return workout.Id;
    }
}
