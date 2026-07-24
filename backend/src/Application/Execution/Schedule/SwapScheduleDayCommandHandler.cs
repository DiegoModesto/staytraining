using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Execution;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Execution.Schedule;

public sealed class SwapScheduleDayCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<SwapScheduleDayCommand, Guid>
{
    public async Task<Result<Guid>> Handle(SwapScheduleDayCommand command, CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        WorkoutSchedule? original = await dbContext.WorkoutSchedules
            .FirstOrDefaultAsync(
                s => s.Id == command.ScheduleId && !s.IsDeleted && (tenantId == null || s.TenantId == tenantId),
                cancellationToken);

        if (original is null
            || (original.StudentId != userContext.UserId && !userContext.HasPermission("student.manage")))
        {
            return Result.Failure<Guid>(WorkoutScheduleErrors.NotFound(command.ScheduleId));
        }

        // New (pending) entry for the same workout on the chosen day.
        var moved = new WorkoutSchedule
        {
            Id = Guid.NewGuid(),
            TenantId = original.TenantId,
            StudentId = original.StudentId,
            WorkoutId = original.WorkoutId,
            ScheduledDate = command.NewDate,
            Status = ScheduleStatus.Pending,
            SwappedFromScheduleId = original.Id,
            CreatedAt = DateTimeOffset.UtcNow,
        };
        dbContext.WorkoutSchedules.Add(moved);

        // Original stays as a record, marked as swapped (does not count as done).
        original.Status = ScheduleStatus.Swapped;
        original.SwappedToScheduleId = moved.Id;
        original.JustificationReason = string.IsNullOrWhiteSpace(command.Reason) ? "troca" : command.Reason;
        original.JustificationNote = string.IsNullOrWhiteSpace(command.Note) ? null : command.Note;

        await dbContext.SaveChangesAsync(cancellationToken);
        return moved.Id;
    }
}
