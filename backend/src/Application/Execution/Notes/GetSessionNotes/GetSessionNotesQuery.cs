using Application.Abstractions.Messaging;

namespace Application.Execution.Notes.GetSessionNotes;

public sealed record GetSessionNotesQuery(Guid SessionId) : IQuery<IReadOnlyCollection<ExerciseNoteResponse>>;
