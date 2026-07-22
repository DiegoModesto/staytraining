using Application.Abstractions.Messaging;
using Application.Workouts;
using Application.Workouts.Templates.Create;
using Domain.Exercises;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.WorkoutTemplates;

internal sealed class CreateWorkoutTemplateEndpoint : IEndpoint
{
    public sealed record Request(
        string Name,
        string? Description,
        ExerciseCategory? Category,
        bool IsSystemDefault,
        string? CreatorNotes,
        IReadOnlyCollection<TemplateItemInput> Items);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("workout-templates", async (
                Request request,
                ICommandHandler<CreateWorkoutTemplateCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new CreateWorkoutTemplateCommand(
                    request.Name,
                    request.Description,
                    request.Category,
                    request.IsSystemDefault,
                    request.CreatorNotes,
                    request.Items ?? []);

                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    id => Results.Created($"/api/v1/workout-templates/{id}", new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.WorkoutTemplates)
            .WithName("CreateWorkoutTemplate")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}template.write");
    }
}
