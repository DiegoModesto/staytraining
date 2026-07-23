using Application.Abstractions.Messaging;
using Application.MuscleGroups.Create;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.MuscleGroups;

internal sealed class CreateMuscleGroupEndpoint : IEndpoint
{
    public sealed record Request(string Name, string BodyRegion);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("muscle-groups", async (
                Request request,
                ICommandHandler<CreateMuscleGroupCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new CreateMuscleGroupCommand(request.Name, request.BodyRegion);
                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    id => Results.Created($"/api/v1/muscle-groups/{id}", new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.MuscleGroups)
            .WithName("CreateMuscleGroup")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}muscle.write");
    }
}
