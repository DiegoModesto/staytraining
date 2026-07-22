namespace CronJobs;

public sealed class CronJobsOptions
{
    public string SampleSchedule { get; set; } = "*/5 * * * *";
    public string SamplePollingSchedule { get; set; } = "*/2 * * * *";

    /// <summary>Daily check for workouts not performed for too long.</summary>
    public string PendingWorkoutSchedule { get; set; } = "0 9 * * *";

    /// <summary>Days without a session before a scheduled workout is considered pending.</summary>
    public int PendingWorkoutDays { get; set; } = 3;

    /// <summary>Weekly report push (default: Mondays 08:00 UTC).</summary>
    public string WeeklyReportSchedule { get; set; } = "0 8 * * 1";
}
