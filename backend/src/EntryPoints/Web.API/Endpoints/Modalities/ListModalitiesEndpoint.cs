using Application.Abstractions.Messaging;
using Application.Modalities;
using Application.Modalities.List;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Modalities;

internal sealed class ListModalitiesEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("modalities", async (
                IQueryHandler<ListModalitiesQuery, IReadOnlyCollection<ModalityResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new ListModalitiesQuery(), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Modalities)
            .WithName("ListModalities")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}modality.read");
    }
}
