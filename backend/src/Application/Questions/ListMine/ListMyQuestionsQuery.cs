using Application.Abstractions.Messaging;

namespace Application.Questions.ListMine;

/// <summary>The current student's own questions (with answers), newest first.</summary>
public sealed record ListMyQuestionsQuery : IQuery<IReadOnlyCollection<QuestionResponse>>;
