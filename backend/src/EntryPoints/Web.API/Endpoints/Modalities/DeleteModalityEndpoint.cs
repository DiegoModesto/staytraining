using Application.Abstractions.Messaging;
using Application.Modalities.Delete;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Modalities;

internal sealed class DeleteModalityEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapDelete("modalities/{id:guid}", async (
                Guid id,
                ICommandHandler<DeleteModalityCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new DeleteModalityCommand(id), cancellationToken);

                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Modalities)
            .WithName("DeleteModality")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}modality.write");
    }
}
