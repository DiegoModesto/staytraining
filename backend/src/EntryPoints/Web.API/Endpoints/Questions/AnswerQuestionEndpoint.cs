using Application.Abstractions.Messaging;
using Application.Questions.Answer;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Questions;

internal sealed class AnswerQuestionEndpoint : IEndpoint
{
    public sealed record Request(string Answer);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("questions/{id:guid}/answer", async (
                Guid id,
                Request request,
                ICommandHandler<AnswerQuestionCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new AnswerQuestionCommand(id, request.Answer), cancellationToken);
                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Questions)
            .WithName("AnswerQuestion")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}question.answer");
    }
}
