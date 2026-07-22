using Application.Abstractions.Messaging;
using Application.Workouts.Workouts.CreateFromTemplate;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Workouts;

internal sealed class CreateWorkoutFromTemplateEndpoint : IEndpoint
{
    public sealed record Request(Guid TemplateId, Guid OwnerStudentId, string? NameOverride);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("workouts/from-template", async (
                Request request,
                ICommandHandler<CreateWorkoutFromTemplateCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new CreateWorkoutFromTemplateCommand(
                    request.TemplateId, request.OwnerStudentId, request.NameOverride);

                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    id => Results.Created($"/api/v1/workouts/{id}", new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Workouts)
            .WithName("CreateWorkoutFromTemplate")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.write");
    }
}
