using Application.Abstractions.Messaging;
using Application.Sync;
using Application.Sync.Push;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Sync;

internal sealed class PushSessionsEndpoint : IEndpoint
{
    public sealed record Request(IReadOnlyCollection<SessionPushInput> Sessions);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("sync/sessions", async (
                Request request,
                ICommandHandler<PushSessionsCommand, SyncPushResult> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(
                    new PushSessionsCommand(request.Sessions ?? []), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Sync)
            .WithName("SyncPushSessions")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}session.write");
    }
}
