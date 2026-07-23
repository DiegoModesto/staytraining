using Application.Abstractions.Messaging;

namespace Application.Questions.ListForTenant;

/// <summary>Questions in the professor's tenant. When <paramref name="OnlyOpen"/> is true, only the
/// unanswered ones (the "pending" queue the professor is notified about).</summary>
public sealed record ListTenantQuestionsQuery(bool OnlyOpen) : IQuery<IReadOnlyCollection<QuestionResponse>>;
