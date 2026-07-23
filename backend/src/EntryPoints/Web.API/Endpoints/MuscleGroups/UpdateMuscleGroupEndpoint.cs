using Application.Abstractions.Messaging;
using Application.MuscleGroups.Update;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.MuscleGroups;

internal sealed class UpdateMuscleGroupEndpoint : IEndpoint
{
    public sealed record Request(string Name, string BodyRegion);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPut("muscle-groups/{id:guid}", async (
                Guid id,
                Request request,
                ICommandHandler<UpdateMuscleGroupCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new UpdateMuscleGroupCommand(id, request.Name, request.BodyRegion);
                var result = await handler.Handle(command, cancellationToken);

                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.MuscleGroups)
            .WithName("UpdateMuscleGroup")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}muscle.write");
    }
}
