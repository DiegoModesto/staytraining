using Application.Abstractions.Messaging;
using Application.Modalities.Create;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Modalities;

internal sealed class CreateModalityEndpoint : IEndpoint
{
    public sealed record Request(string Name, string ColorHex, bool IsIntervalBased, int SortOrder);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("modalities", async (
                Request request,
                ICommandHandler<CreateModalityCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new CreateModalityCommand(
                    request.Name, request.ColorHex, request.IsIntervalBased, request.SortOrder);

                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    id => Results.Created($"/api/v1/modalities/{id}", new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Modalities)
            .WithName("CreateModality")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}modality.write");
    }
}
