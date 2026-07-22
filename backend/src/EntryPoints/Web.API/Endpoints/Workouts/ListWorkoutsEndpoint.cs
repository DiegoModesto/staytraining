using Application.Abstractions.Messaging;
using Application.Workouts;
using Application.Workouts.Workouts.List;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Workouts;

internal sealed class ListWorkoutsEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("workouts", async (
                Guid? ownerStudentId,
                IQueryHandler<ListWorkoutsQuery, IReadOnlyCollection<WorkoutListItemResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new ListWorkoutsQuery(ownerStudentId), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Workouts)
            .WithName("ListWorkouts")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.read");
    }
}
