using Application.Abstractions.Messaging;
using Application.Modalities.Update;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Modalities;

internal sealed class UpdateModalityEndpoint : IEndpoint
{
    public sealed record Request(string Name, string ColorHex, bool IsIntervalBased, int SortOrder);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPut("modalities/{id:guid}", async (
                Guid id,
                Request request,
                ICommandHandler<UpdateModalityCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new UpdateModalityCommand(
                    id, request.Name, request.ColorHex, request.IsIntervalBased, request.SortOrder);

                var result = await handler.Handle(command, cancellationToken);

                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Modalities)
            .WithName("UpdateModality")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}modality.write");
    }
}
