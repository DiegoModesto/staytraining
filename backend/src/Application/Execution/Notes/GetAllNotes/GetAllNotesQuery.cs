using Application.Abstractions.Messaging;

namespace Application.Execution.Notes.GetAllNotes;

/// <summary>
/// Returns all exercise notes for a student across sessions, ordered by day (newest first),
/// optionally filtered by exercise. This is the per-day / per-exercise history ("apanhado").
/// </summary>
public sealed record GetAllNotesQuery(Guid? StudentId, Guid? ExerciseId)
    : IQuery<IReadOnlyCollection<ExerciseNoteResponse>>;
