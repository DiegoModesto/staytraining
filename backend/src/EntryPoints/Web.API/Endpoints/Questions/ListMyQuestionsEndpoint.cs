using Application.Abstractions.Messaging;
using Application.Questions;
using Application.Questions.ListMine;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Questions;

internal sealed class ListMyQuestionsEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("questions/mine", async (
                IQueryHandler<ListMyQuestionsQuery, IReadOnlyCollection<QuestionResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new ListMyQuestionsQuery(), cancellationToken);
                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Questions)
            .WithName("ListMyQuestions")
            // App baseline permission: any app user (student or professor training themselves) can
            // read their own questions.
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.read");
    }
}
