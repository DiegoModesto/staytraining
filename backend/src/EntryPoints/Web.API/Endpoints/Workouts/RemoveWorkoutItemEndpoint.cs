using Application.Abstractions.Messaging;
using Application.Workouts.Workouts.RemoveItem;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Workouts;

internal sealed class RemoveWorkoutItemEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapDelete("workouts/{id:guid}/items/{itemId:guid}", async (
                Guid id,
                Guid itemId,
                ICommandHandler<RemoveWorkoutItemCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new RemoveWorkoutItemCommand(id, itemId), cancellationToken);

                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Workouts)
            .WithName("RemoveWorkoutItem")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.write");
    }
}
