using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Execution;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Execution.Schedule;

public sealed class ScheduleWorkoutForDayCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<ScheduleWorkoutForDayCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        ScheduleWorkoutForDayCommand command,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to schedule a workout.");
        Guid studentId = userContext.UserId;

        bool workoutExists = await dbContext.Workouts
            .AnyAsync(w => w.Id == command.WorkoutId && !w.IsDeleted && w.TenantId == tenantId, cancellationToken);

        if (!workoutExists)
        {
            return Result.Failure<Guid>(WorkoutErrors.NotFound(command.WorkoutId));
        }

        var schedule = new WorkoutSchedule
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            StudentId = studentId,
            WorkoutId = command.WorkoutId,
            ScheduledDate = command.Date,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        dbContext.WorkoutSchedules.Add(schedule);
        await dbContext.SaveChangesAsync(cancellationToken);

        return schedule.Id;
    }
}
