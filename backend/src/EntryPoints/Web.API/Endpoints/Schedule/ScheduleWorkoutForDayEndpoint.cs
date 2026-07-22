using Application.Abstractions.Messaging;
using Application.Execution.Schedule;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Schedule;

internal sealed class ScheduleWorkoutForDayEndpoint : IEndpoint
{
    public sealed record Request(Guid WorkoutId, DateOnly Date);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("schedule", async (
                Request request,
                ICommandHandler<ScheduleWorkoutForDayCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(
                    new ScheduleWorkoutForDayCommand(request.WorkoutId, request.Date), cancellationToken);

                return result.Match(
                    id => Results.Created($"/api/v1/schedule/{id}", new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Schedule)
            .WithName("ScheduleWorkoutForDay")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}session.write");
    }
}
