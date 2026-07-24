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

        // Only a manager (professor) may read another student's week.
        if (query.StudentId is not null
            && query.StudentId != userContext.UserId
            && !userContext.HasPermission("student.read"))
        {
            return Result.Failure<IReadOnlyCollection<WeekScheduleItemResponse>>(
                Error.Forbidden("Schedule.Forbidden", "Not allowed to read this student's schedule."));
        }

        DateOnly weekEnd = query.WeekStart.AddDays(7);

        // Completion is evaluated within the week window (DateTimeOffset bounds translate safely).
        var weekStartUtc = new DateTimeOffset(query.WeekStart.ToDateTime(TimeOnly.MinValue), TimeSpan.Zero);
        var weekEndUtc = new DateTimeOffset(weekEnd.ToDateTime(TimeOnly.MinValue), TimeSpan.Zero);

        var raw = await dbContext.WorkoutSchedules
            .Where(s => !s.IsDeleted
                && s.StudentId == studentId
                && (tenantId == null || s.TenantId == tenantId)
                && s.ScheduledDate >= query.WeekStart
                && s.ScheduledDate < weekEnd)
            .OrderBy(s => s.ScheduledDate)
            .Join(dbContext.Workouts,
                s => s.WorkoutId,
                w => w.Id,
                (s, w) => new
                {
                    s.Id,
                    s.ScheduledDate,
                    WorkoutId = w.Id,
                    w.Name,
                    Completed = dbContext.WorkoutSessions.Any(ss =>
                        ss.WorkoutId == s.WorkoutId
                        && ss.StudentId == studentId
                        && ss.CompletedAt != null
                        && ss.CompletedAt >= weekStartUtc
                        && ss.CompletedAt < weekEndUtc),
                    s.Status,
                    s.JustificationReason,
                    s.JustificationNote,
                    SwappedToDate = s.SwappedToScheduleId == null
                        ? (DateOnly?)null
                        : dbContext.WorkoutSchedules
                            .Where(x => x.Id == s.SwappedToScheduleId)
                            .Select(x => (DateOnly?)x.ScheduledDate)
                            .FirstOrDefault(),
                    s.SwappedFromScheduleId,
                })
            .ToListAsync(cancellationToken);

        List<WeekScheduleItemResponse> items = raw
            .Select(r => new WeekScheduleItemResponse(
                r.Id,
                r.ScheduledDate,
                r.WorkoutId,
                r.Name,
                r.Completed,
                r.Status.ToString(),
                r.JustificationReason,
                r.JustificationNote,
                r.SwappedToDate,
                r.SwappedFromScheduleId))
            .ToList();

        return items;
    }
}
