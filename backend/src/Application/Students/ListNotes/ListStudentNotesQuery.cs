using Application.Abstractions.Messaging;

namespace Application.Students.ListNotes;

public sealed record ListStudentNotesQuery(Guid StudentProfileId)
    : IQuery<IReadOnlyCollection<StudentNoteResponse>>;
