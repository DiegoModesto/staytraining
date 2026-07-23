using Application.Abstractions.Messaging;

namespace Application.Students.AddStudentNote;

/// <summary>Adds a professor annotation to a student's sheet (visible to professors only).</summary>
public sealed record AddStudentNoteCommand(Guid StudentProfileId, string Content) : ICommand<Guid>;
