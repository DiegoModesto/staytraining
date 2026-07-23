using Application.Abstractions.Messaging;
using Application.MuscleGroups.Delete;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.MuscleGroups;

internal sealed class DeleteMuscleGroupEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapDelete("muscle-groups/{id:guid}", async (
                Guid id,
                ICommandHandler<DeleteMuscleGroupCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new DeleteMuscleGroupCommand(id), cancellationToken);

                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.MuscleGroups)
            .WithName("DeleteMuscleGroup")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}muscle.write");
    }
}
