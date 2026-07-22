using Application.Abstractions.Messaging;
using Application.Workouts;
using Application.Workouts.Templates.GetById;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.WorkoutTemplates;

internal sealed class GetWorkoutTemplateByIdEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("workout-templates/{id:guid}", async (
                Guid id,
                IQueryHandler<GetWorkoutTemplateByIdQuery, WorkoutTemplateResponse> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new GetWorkoutTemplateByIdQuery(id), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.WorkoutTemplates)
            .WithName("GetWorkoutTemplateById")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}template.read");
    }
}
