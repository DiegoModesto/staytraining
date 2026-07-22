using Application.Abstractions.Messaging;
using Application.Execution.Sessions.Start;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Sessions;

internal sealed class StartSessionEndpoint : IEndpoint
{
    public sealed record Request(Guid WorkoutId);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("sessions", async (
                Request request,
                ICommandHandler<StartSessionCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new StartSessionCommand(request.WorkoutId), cancellationToken);

                return result.Match(
                    id => Results.Created($"/api/v1/sessions/{id}", new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Sessions)
            .WithName("StartSession")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}session.write");
    }
}
