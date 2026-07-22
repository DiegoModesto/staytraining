using Application.Abstractions.Messaging;
using Application.Execution.Sessions.Complete;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Sessions;

internal sealed class CompleteSessionEndpoint : IEndpoint
{
    public sealed record Request(int? CompletionRating, string? OverallComment);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("sessions/{id:guid}/complete", async (
                Guid id,
                Request request,
                ICommandHandler<CompleteSessionCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(
                    new CompleteSessionCommand(id, request.CompletionRating, request.OverallComment),
                    cancellationToken);

                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Sessions)
            .WithName("CompleteSession")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}session.write");
    }
}
