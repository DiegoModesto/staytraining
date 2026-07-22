using Application.Abstractions.Messaging;
using Application.MuscleGroups.List;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.MuscleGroups;

internal sealed class ListMuscleGroupsEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("muscle-groups", async (
                IQueryHandler<ListMuscleGroupsQuery, IReadOnlyCollection<MuscleGroupResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new ListMuscleGroupsQuery(), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.MuscleGroups)
            .WithName("ListMuscleGroups")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}exercise.read");
    }
}
