using Application.Abstractions.Messaging;
using Application.Workouts.Workouts.ReorderItems;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Workouts;

internal sealed class ReorderWorkoutItemsEndpoint : IEndpoint
{
    public sealed record Request(IReadOnlyList<Guid> OrderedItemIds);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPut("workouts/{id:guid}/items/order", async (
                Guid id,
                Request request,
                ICommandHandler<ReorderWorkoutItemsCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(
                    new ReorderWorkoutItemsCommand(id, request.OrderedItemIds ?? []), cancellationToken);

                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Workouts)
            .WithName("ReorderWorkoutItems")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.write");
    }
}
