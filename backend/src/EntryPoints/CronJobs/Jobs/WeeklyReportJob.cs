using Application.Abstractions.Data;
using Application.Abstractions.Notifications;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

namespace CronJobs.Jobs;

/// <summary>
/// Weekly scan: pushes each active student a synthesized summary of the previous 7 days
/// (sessions performed and distinct workouts).
/// </summary>
public sealed class WeeklyReportJob(
    IServiceScopeFactory scopeFactory,
    IOptions<CronJobsOptions> options,
    ILogger<WeeklyReportJob> logger)
    : CronBackgroundService(options.Value.WeeklyReportSchedule, logger)
{
    protected override async Task RunAsync(CancellationToken cancellationToken)
    {
        using IServiceScope scope = scopeFactory.CreateScope();
        var dbContext = scope.ServiceProvider.GetRequiredService<IApplicationDbContext>();
        var pushSender = scope.ServiceProvider.GetRequiredService<IPushSender>();

        DateTimeOffset from = DateTimeOffset.UtcNow.AddDays(-7);

        var perStudent = await dbContext.WorkoutSessions
            .Where(s => !s.IsDeleted && s.StartedAt >= from)
            .GroupBy(s => s.StudentId)
            .Select(g => new
            {
                StudentId = g.Key,
                Sessions = g.Count(),
                Workouts = g.Select(x => x.WorkoutId).Distinct().Count(),
            })
            .ToListAsync(cancellationToken);

        foreach (var s in perStudent)
        {
            string body = $"Na última semana: {s.Sessions} treino(s) em {s.Workouts} ficha(s). Continue firme!";
            await pushSender.SendToUserAsync(
                s.StudentId, "Seu resumo semanal", body, data: null, cancellationToken);
        }

        logger.LogInformation("WeeklyReportJob pushed summaries to {Count} student(s).", perStudent.Count);
    }
}
