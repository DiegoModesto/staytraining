using Application.Abstractions.Messaging;
using Application.Students.AddHealthObservation;
using Domain.Students;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Students;

internal sealed class AddHealthObservationEndpoint : IEndpoint
{
    public sealed record Request(HealthObservationKind Kind, string Title, string? Detail);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("students/{id:guid}/health", async (
                Guid id,
                Request request,
                ICommandHandler<AddHealthObservationCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new AddHealthObservationCommand(id, request.Kind, request.Title, request.Detail);

                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    obsId => Results.Created($"/api/v1/students/{id}/health/{obsId}", new { id = obsId }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Students)
            .WithName("AddHealthObservation")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}health.write");
    }
}
