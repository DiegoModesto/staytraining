using Application.Abstractions.Messaging;
using Application.Questions.Ask;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Questions;

internal sealed class AskQuestionEndpoint : IEndpoint
{
    public sealed record Request(Guid? WorkoutId, Guid? ExerciseId, string Text);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("questions", async (
                Request request,
                ICommandHandler<AskQuestionCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new AskQuestionCommand(request.WorkoutId, request.ExerciseId, request.Text);
                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    id => Results.Created($"/api/v1/questions/{id}", new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Questions)
            .WithName("AskQuestion")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}question.ask");
    }
}
