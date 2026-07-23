namespace Domain.Questions;

/// <summary>A question a student asks their professor about a workout or an exercise, and the
/// professor's answer. Plain persistence POCO (mapped by convention + QuestionConfiguration).</summary>
public sealed class Question
{
    public Guid Id { get; set; }
    public Guid TenantId { get; set; }

    /// <summary>The asking student's user id.</summary>
    public Guid StudentId { get; set; }
    public string StudentName { get; set; } = string.Empty;

    /// <summary>Target of the question — at least one of these is set.</summary>
    public Guid? WorkoutId { get; set; }
    public Guid? ExerciseId { get; set; }

    public string Text { get; set; } = string.Empty;

    public string? AnswerText { get; set; }
    public Guid? AnsweredByUserId { get; set; }
    public string? AnsweredByName { get; set; }
    public DateTimeOffset? AnsweredAt { get; set; }

    public DateTimeOffset CreatedAt { get; set; }

    public bool IsAnswered => AnswerText is not null;
}
