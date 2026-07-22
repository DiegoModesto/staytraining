using Application.Abstractions.Messaging;
using Application.Sync;
using Application.Sync.Pull;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Sync;

internal sealed class PullChangesEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("sync/pull", async (
                DateTimeOffset? since,
                IQueryHandler<PullChangesQuery, SyncPullResponse> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new PullChangesQuery(since), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Sync)
            .WithName("SyncPull")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.read");
    }
}
