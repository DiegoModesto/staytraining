namespace Domain.Execution;

/// <summary>Status of a scheduled workout (completion is derived from sessions, not stored here).</summary>
public enum ScheduleStatus
{
    /// <summary>Planned and still to be done.</summary>
    Pending = 0,

    /// <summary>The student justified not doing it (holiday, gym closed, illness, etc.).</summary>
    Skipped = 1,

    /// <summary>The student moved this workout to another day; this entry does not count as done.</summary>
    Swapped = 2,
}
