using Application.Abstractions.Messaging;
using Application.Workouts;
using Application.Workouts.Workouts.GetById;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Workouts;

internal sealed class GetWorkoutByIdEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("workouts/{id:guid}", async (
                Guid id,
                IQueryHandler<GetWorkoutByIdQuery, WorkoutResponse> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new GetWorkoutByIdQuery(id), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Workouts)
            .WithName("GetWorkoutById")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.read");
    }
}
