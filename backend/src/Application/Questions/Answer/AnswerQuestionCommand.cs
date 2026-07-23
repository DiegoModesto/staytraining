using Application.Abstractions.Messaging;

namespace Application.Questions.Answer;

/// <summary>A professor answers a student's question.</summary>
public sealed record AnswerQuestionCommand(Guid QuestionId, string Answer) : ICommand;
