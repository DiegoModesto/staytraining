using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Execution.Schedule;

public sealed class GetWeekScheduleQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<GetWeekScheduleQuery, IReadOnlyCollection<WeekScheduleItemResponse>>
{
    public async Task<Result<IReadOnlyCollection<WeekScheduleItemResponse>>> Handle(
        GetWeekScheduleQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;
        Guid studentId = query.StudentId ?? userContext.UserId;
        DateOnly weekEnd = query.WeekStart.AddDays(7);

        List<WeekScheduleItemResponse> items = await dbContext.WorkoutSchedules
            .Where(s => !s.IsDeleted
                && s.StudentId == studentId
                && (tenantId == null || s.TenantId == tenantId)
                && s.ScheduledDate >= query.WeekStart
                && s.ScheduledDate < weekEnd)
            .OrderBy(s => s.ScheduledDate)
            .Join(dbContext.Workouts,
                s => s.WorkoutId,
                w => w.Id,
                (s, w) => new WeekScheduleItemResponse(s.Id, s.ScheduledDate, w.Id, w.Name))
            .ToListAsync(cancellationToken);

        return items;
    }
}
