using Application.Abstractions.Messaging;
using Application.Questions;
using Application.Questions.ListForTenant;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Questions;

internal sealed class ListTenantQuestionsEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("questions", async (
                bool? onlyOpen,
                IQueryHandler<ListTenantQuestionsQuery, IReadOnlyCollection<QuestionResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(
                    new ListTenantQuestionsQuery(onlyOpen ?? false), cancellationToken);
                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Questions)
            .WithName("ListTenantQuestions")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}question.answer");
    }
}
