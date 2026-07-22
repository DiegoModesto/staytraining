using Application.Abstractions.Messaging;
using Application.Execution;
using Application.Execution.Reports.GetWeeklyReport;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Reports;

internal sealed class GetWeeklyReportEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("reports/weekly", async (
                DateOnly weekStart,
                Guid? studentId,
                IQueryHandler<GetWeeklyReportQuery, WeeklyReportResponse> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new GetWeeklyReportQuery(weekStart, studentId), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Reports)
            .WithName("GetWeeklyReport")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}report.read");
    }
}
