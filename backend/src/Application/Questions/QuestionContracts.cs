namespace Application.Questions;

/// <summary>A question with its (optional) answer, projected for the app and backoffice.</summary>
public sealed record QuestionResponse(
    Guid Id,
    Guid StudentId,
    string StudentName,
    Guid? WorkoutId,
    string? WorkoutName,
    Guid? ExerciseId,
    string? ExerciseName,
    string Text,
    DateTimeOffset CreatedAt,
    string? AnswerText,
    string? AnsweredByName,
    DateTimeOffset? AnsweredAt,
    bool IsAnswered);
