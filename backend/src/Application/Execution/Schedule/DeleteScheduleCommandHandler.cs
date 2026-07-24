using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Execution;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Execution.Schedule;

public sealed class DeleteScheduleCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<DeleteScheduleCommand>
{
    public async Task<Result> Handle(DeleteScheduleCommand command, CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        WorkoutSchedule? schedule = await dbContext.WorkoutSchedules
            .FirstOrDefaultAsync(
                s => s.Id == command.ScheduleId && !s.IsDeleted && (tenantId == null || s.TenantId == tenantId),
                cancellationToken);

        if (schedule is null
            || (schedule.StudentId != userContext.UserId && !userContext.HasPermission("student.manage")))
        {
            return Result.Failure(WorkoutScheduleErrors.NotFound(command.ScheduleId));
        }

        schedule.IsDeleted = true;
        schedule.DeletedAt = DateTimeOffset.UtcNow;

        await dbContext.SaveChangesAsync(cancellationToken);
        return Result.Success();
    }
}
