using Application.Abstractions.Messaging;
using Application.Execution.Schedule;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Schedule;

internal sealed class DeleteScheduleEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapDelete("schedule/{id:guid}", async (
                Guid id,
                ICommandHandler<DeleteScheduleCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new DeleteScheduleCommand(id), cancellationToken);
                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Schedule)
            .WithName("DeleteSchedule")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}session.write");
    }
}
