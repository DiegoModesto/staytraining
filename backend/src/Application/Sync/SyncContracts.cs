using Application.Exercises;
using Application.MuscleGroups.List;
using Application.Workouts;

namespace Application.Sync;

public sealed record ScheduleSyncItem(Guid Id, DateOnly Date, Guid WorkoutId);

/// <summary>
/// Delta payload for offline clients: entities changed since the client's last sync, plus the ids
/// of entities soft-deleted since then so the client can remove them locally.
/// </summary>
public sealed record SyncPullResponse(
    DateTimeOffset ServerTime,
    IReadOnlyCollection<MuscleGroupResponse> MuscleGroups,
    IReadOnlyCollection<Guid> DeletedMuscleGroupIds,
    IReadOnlyCollection<ExerciseResponse> Exercises,
    IReadOnlyCollection<Guid> DeletedExerciseIds,
    IReadOnlyCollection<WorkoutTemplateResponse> Templates,
    IReadOnlyCollection<Guid> DeletedTemplateIds,
    IReadOnlyCollection<WorkoutResponse> Workouts,
    IReadOnlyCollection<Guid> DeletedWorkoutIds,
    IReadOnlyCollection<ScheduleSyncItem> Schedules,
    IReadOnlyCollection<Guid> DeletedScheduleIds);

public sealed record NotePushInput(
    Guid Id,
    Guid WorkoutItemId,
    Guid ExerciseId,
    decimal? LoadKg,
    bool PainFlag,
    string? PainNote,
    string? Comment,
    int? PerformedSets,
    int? PerformedReps,
    DateTimeOffset CreatedAt);

public sealed record SessionPushInput(
    Guid Id,
    Guid WorkoutId,
    DateTimeOffset StartedAt,
    DateTimeOffset? CompletedAt,
    int? CompletionRating,
    string? OverallComment,
    IReadOnlyCollection<NotePushInput> Notes);

public sealed record SyncPushResult(int SessionsInserted, int SessionsSkipped);
