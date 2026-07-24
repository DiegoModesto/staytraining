using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Execution;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Execution.Schedule;

public sealed class JustifySkipScheduleCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<JustifySkipScheduleCommand>
{
    public async Task<Result> Handle(JustifySkipScheduleCommand command, CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        WorkoutSchedule? schedule = await dbContext.WorkoutSchedules
            .FirstOrDefaultAsync(
                s => s.Id == command.ScheduleId && !s.IsDeleted && (tenantId == null || s.TenantId == tenantId),
                cancellationToken);

        // Owner-only unless a manager (professor).
        if (schedule is null
            || (schedule.StudentId != userContext.UserId && !userContext.HasPermission("student.manage")))
        {
            return Result.Failure(WorkoutScheduleErrors.NotFound(command.ScheduleId));
        }

        schedule.Status = ScheduleStatus.Skipped;
        schedule.JustificationReason = command.Reason;
        schedule.JustificationNote = string.IsNullOrWhiteSpace(command.Note) ? null : command.Note;

        await dbContext.SaveChangesAsync(cancellationToken);
        return Result.Success();
    }
}
