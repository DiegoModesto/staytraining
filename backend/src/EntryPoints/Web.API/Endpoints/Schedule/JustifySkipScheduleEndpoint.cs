using Application.Abstractions.Messaging;
using Application.Execution.Schedule;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Schedule;

internal sealed class JustifySkipScheduleEndpoint : IEndpoint
{
    public sealed record Request(string Reason, string? Note);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("schedule/{id:guid}/skip", async (
                Guid id,
                Request request,
                ICommandHandler<JustifySkipScheduleCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(
                    new JustifySkipScheduleCommand(id, request.Reason, request.Note), cancellationToken);

                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Schedule)
            .WithName("JustifySkipSchedule")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}session.write");
    }
}
