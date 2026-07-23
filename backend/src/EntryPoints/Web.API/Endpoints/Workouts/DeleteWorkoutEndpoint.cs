using Application.Abstractions.Messaging;
using Application.Workouts.Workouts.Delete;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Workouts;

internal sealed class DeleteWorkoutEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapDelete("workouts/{id:guid}", async (
                Guid id,
                ICommandHandler<DeleteWorkoutCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new DeleteWorkoutCommand(id), cancellationToken);

                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Workouts)
            .WithName("DeleteWorkout")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.write");
    }
}
