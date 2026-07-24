using Application.Abstractions.Messaging;
using Application.Execution.Schedule;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Schedule;

internal sealed class SwapScheduleDayEndpoint : IEndpoint
{
    public sealed record Request(DateOnly NewDate, string? Reason, string? Note);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("schedule/{id:guid}/swap", async (
                Guid id,
                Request request,
                ICommandHandler<SwapScheduleDayCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(
                    new SwapScheduleDayCommand(id, request.NewDate, request.Reason, request.Note), cancellationToken);

                return result.Match(
                    newId => Results.Created($"/api/v1/schedule/{newId}", new { id = newId }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Schedule)
            .WithName("SwapScheduleDay")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}session.write");
    }
}
