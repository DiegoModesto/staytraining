using Application.Abstractions.Data;
using Application.Abstractions.Notifications;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

namespace CronJobs.Jobs;

/// <summary>
/// Daily scan: for each scheduled (student, workout) pair, if no session has been performed for
/// more than <see cref="CronJobsOptions.PendingWorkoutDays"/> days, pushes a "pending workout"
/// notification to the student.
/// </summary>
public sealed class PendingWorkoutJob(
    IServiceScopeFactory scopeFactory,
    IOptions<CronJobsOptions> options,
    ILogger<PendingWorkoutJob> logger)
    : CronBackgroundService(options.Value.PendingWorkoutSchedule, logger)
{
    private readonly int _thresholdDays = options.Value.PendingWorkoutDays;

    protected override async Task RunAsync(CancellationToken cancellationToken)
    {
        using IServiceScope scope = scopeFactory.CreateScope();
        var dbContext = scope.ServiceProvider.GetRequiredService<IApplicationDbContext>();
        var pushSender = scope.ServiceProvider.GetRequiredService<IPushSender>();

        var pairs = await dbContext.WorkoutSchedules
            .Where(s => !s.IsDeleted)
            .Select(s => new { s.StudentId, s.WorkoutId })
            .Distinct()
            .ToListAsync(cancellationToken);

        if (pairs.Count == 0)
        {
            return;
        }

        var lastSessions = await dbContext.WorkoutSessions
            .Where(s => !s.IsDeleted)
            .GroupBy(s => new { s.StudentId, s.WorkoutId })
            .Select(g => new { g.Key.StudentId, g.Key.WorkoutId, Last = g.Max(x => x.StartedAt) })
            .ToListAsync(cancellationToken);

        var lastByPair = lastSessions.ToDictionary(x => (x.StudentId, x.WorkoutId), x => x.Last);

        var workoutNames = await dbContext.Workouts
            .Where(w => !w.IsDeleted)
            .Select(w => new { w.Id, w.Name })
            .ToListAsync(cancellationToken);
        var nameById = workoutNames.ToDictionary(x => x.Id, x => x.Name);

        DateTimeOffset now = DateTimeOffset.UtcNow;
        int notified = 0;

        foreach (var pair in pairs)
        {
            lastByPair.TryGetValue((pair.StudentId, pair.WorkoutId), out DateTimeOffset last);
            int daysSince = last == default ? int.MaxValue : (int)(now - last).TotalDays;

            if (daysSince < _thresholdDays)
            {
                continue;
            }

            string name = nameById.TryGetValue(pair.WorkoutId, out string? n) ? n : "seu treino";
            string body = last == default
                ? $"Você ainda não realizou o treino \"{name}\"."
                : $"Faz {daysSince} dias que você não faz o treino \"{name}\".";

            await pushSender.SendToUserAsync(
                pair.StudentId,
                "Treino pendente",
                body,
                new Dictionary<string, string> { ["workoutId"] = pair.WorkoutId.ToString() },
                cancellationToken);

            notified++;
        }

        logger.LogInformation("PendingWorkoutJob notified {Count} pending workout(s).", notified);
    }
}
