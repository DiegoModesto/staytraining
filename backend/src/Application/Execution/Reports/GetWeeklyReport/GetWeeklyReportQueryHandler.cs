using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Execution;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Execution.Reports.GetWeeklyReport;

public sealed class GetWeeklyReportQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<GetWeeklyReportQuery, WeeklyReportResponse>
{
    public async Task<Result<WeeklyReportResponse>> Handle(
        GetWeeklyReportQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;
        Guid studentId = query.StudentId ?? userContext.UserId;

        DateOnly weekEnd = query.WeekStart.AddDays(7);
        DateTimeOffset from = new(query.WeekStart.ToDateTime(TimeOnly.MinValue), TimeSpan.Zero);
        DateTimeOffset to = new(weekEnd.ToDateTime(TimeOnly.MinValue), TimeSpan.Zero);

        List<WorkoutSession> sessions = await dbContext.WorkoutSessions
            .Include(s => s.Notes)
            .Where(s => !s.IsDeleted
                && s.StudentId == studentId
                && (tenantId == null || s.TenantId == tenantId)
                && s.StartedAt >= from
                && s.StartedAt < to)
            .ToListAsync(cancellationToken);

        List<WeeklyReportSession> sessionSummaries = sessions
            .OrderBy(s => s.StartedAt)
            .Select(s => new WeeklyReportSession(
                s.Id, s.WorkoutId, s.StartedAt, s.CompletedAt, s.CompletionRating, s.Notes.Count))
            .ToList();

        List<WeeklyReportExercise> exerciseSummaries = sessions
            .SelectMany(s => s.Notes)
            .GroupBy(n => n.ExerciseId)
            .Select(g => new WeeklyReportExercise(
                g.Key,
                g.Count(),
                g.Sum(n => n.PerformedSets ?? 0),
                g.Sum(n => n.PerformedReps ?? 0),
                g.Max(n => n.LoadKg)))
            .OrderByDescending(e => e.TimesPerformed)
            .ToList();

        List<int> ratings = sessions
            .Where(s => s.CompletionRating.HasValue)
            .Select(s => s.CompletionRating!.Value)
            .ToList();

        var report = new WeeklyReportResponse(
            query.WeekStart,
            weekEnd.AddDays(-1),
            sessions.Count,
            sessions.Count(s => s.CompletedAt is not null),
            ratings.Count > 0 ? ratings.Average() : null,
            sessions.Select(s => s.WorkoutId).Distinct().Count(),
            sessionSummaries,
            exerciseSummaries);

        return report;
    }
}
