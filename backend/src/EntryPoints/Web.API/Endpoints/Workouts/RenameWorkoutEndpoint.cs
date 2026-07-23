using Application.Abstractions.Messaging;
using Application.Workouts.Workouts.Rename;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Workouts;

internal sealed class RenameWorkoutEndpoint : IEndpoint
{
    public sealed record Request(string Name);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPut("workouts/{id:guid}/name", async (
                Guid id,
                Request request,
                ICommandHandler<RenameWorkoutCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new RenameWorkoutCommand(id, request.Name), cancellationToken);

                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Workouts)
            .WithName("RenameWorkout")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.write");
    }
}
