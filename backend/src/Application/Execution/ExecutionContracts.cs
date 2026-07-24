namespace Application.Execution;

public sealed record WeekScheduleItemResponse(
    Guid ScheduleId,
    DateOnly Date,
    Guid WorkoutId,
    string WorkoutName,
    bool Completed,
    string Status,
    string? JustificationReason,
    string? JustificationNote,
    DateOnly? SwappedToDate,
    Guid? SwappedFromScheduleId);

public sealed record ExerciseNoteResponse(
    Guid Id,
    Guid SessionId,
    DateTimeOffset SessionDate,
    Guid WorkoutItemId,
    Guid ExerciseId,
    decimal? LoadKg,
    bool PainFlag,
    string? PainNote,
    string? Comment,
    int? PerformedSets,
    int? PerformedReps,
    DateTimeOffset CreatedAt);

public sealed record WeeklyReportSession(
    Guid SessionId,
    Guid WorkoutId,
    DateTimeOffset StartedAt,
    DateTimeOffset? CompletedAt,
    int? Rating,
    int NoteCount);

public sealed record WeeklyReportExercise(
    Guid ExerciseId,
    int TimesPerformed,
    int TotalSets,
    int TotalReps,
    decimal? MaxLoadKg);

public sealed record WeeklyReportResponse(
    DateOnly WeekStart,
    DateOnly WeekEnd,
    int SessionCount,
    int CompletedSessionCount,
    double? AverageRating,
    int DistinctWorkoutCount,
    IReadOnlyCollection<WeeklyReportSession> Sessions,
    IReadOnlyCollection<WeeklyReportExercise> Exercises);
