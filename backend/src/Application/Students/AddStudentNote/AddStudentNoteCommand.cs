using Application.Abstractions.Messaging;

namespace Application.Students.AddStudentNote;

/// <summary>Adds a professor annotation to a student's sheet (visible to professors only).
/// <paramref name="WorkoutId"/> null = general (Ficha tab); set = scoped to that workout (Treinos tab).</summary>
public sealed record AddStudentNoteCommand(Guid StudentProfileId, string Content, Guid? WorkoutId = null) : ICommand<Guid>;
