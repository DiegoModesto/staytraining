using Application.Abstractions.Messaging;
using Application.Workouts;
using Application.Workouts.Templates.List;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.WorkoutTemplates;

internal sealed class ListWorkoutTemplatesEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("workout-templates", async (
                bool? onlySystemDefaults,
                IQueryHandler<ListWorkoutTemplatesQuery, IReadOnlyCollection<WorkoutTemplateListItemResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(
                    new ListWorkoutTemplatesQuery(onlySystemDefaults), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.WorkoutTemplates)
            .WithName("ListWorkoutTemplates")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}template.read");
    }
}
