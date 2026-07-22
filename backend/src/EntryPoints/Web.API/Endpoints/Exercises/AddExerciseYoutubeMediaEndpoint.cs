using Application.Abstractions.Messaging;
using Application.Exercises.AddMedia;
using Domain.Exercises;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Exercises;

internal sealed class AddExerciseYoutubeMediaEndpoint : IEndpoint
{
    public sealed record Request(string Url);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("exercises/{id:guid}/media/youtube", async (
                Guid id,
                Request request,
                ICommandHandler<AddExerciseMediaCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new AddExerciseMediaCommand(
                    id, ExerciseMediaKind.YoutubeUrl, null, request.Url, null, null);

                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    mediaId => Results.Created($"/api/v1/exercises/{id}/media/{mediaId}", new { id = mediaId }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Exercises)
            .WithName("AddExerciseYoutubeMedia")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}exercise.write");
    }
}
