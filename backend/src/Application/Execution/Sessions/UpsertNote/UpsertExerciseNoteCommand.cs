using Application.Abstractions.Messaging;

namespace Application.Execution.Sessions.UpsertNote;

/// <summary>Creates or updates the note for one exercise (workout item) within a session.</summary>
public sealed record UpsertExerciseNoteCommand(
    Guid SessionId,
    Guid WorkoutItemId,
    Guid ExerciseId,
    decimal? LoadKg,
    bool PainFlag,
    string? PainNote,
    string? Comment,
    int? PerformedSets,
    int? PerformedReps)
    : ICommand<Guid>;
