using Application.Abstractions.Messaging;
using Application.Workouts;
using Application.Workouts.Workouts.AddItem;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Workouts;

internal sealed class AddWorkoutItemEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("workouts/{id:guid}/items", async (
                Guid id,
                WorkoutItemInput item,
                ICommandHandler<AddWorkoutItemCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new AddWorkoutItemCommand(id, item), cancellationToken);

                return result.Match(
                    itemId => Results.Created($"/api/v1/workouts/{id}/items/{itemId}", new { id = itemId }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Workouts)
            .WithName("AddWorkoutItem")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.write");
    }
}
