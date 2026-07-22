using Application.Abstractions.Messaging;
using Application.Execution;
using Application.Execution.Schedule;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Schedule;

internal sealed class GetWeekScheduleEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("schedule/week", async (
                DateOnly weekStart,
                Guid? studentId,
                IQueryHandler<GetWeekScheduleQuery, IReadOnlyCollection<WeekScheduleItemResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(
                    new GetWeekScheduleQuery(weekStart, studentId), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Schedule)
            .WithName("GetWeekSchedule")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.read");
    }
}
