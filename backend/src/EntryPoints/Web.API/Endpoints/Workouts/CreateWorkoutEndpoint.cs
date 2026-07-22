using Application.Abstractions.Messaging;
using Application.Workouts;
using Application.Workouts.Workouts.Create;
using Domain.Exercises;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Workouts;

internal sealed class CreateWorkoutEndpoint : IEndpoint
{
    public sealed record Request(
        Guid OwnerStudentId,
        string Name,
        string? Description,
        ExerciseCategory? Category,
        IReadOnlyCollection<WorkoutItemInput> Items);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("workouts", async (
                Request request,
                ICommandHandler<CreateWorkoutCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new CreateWorkoutCommand(
                    request.OwnerStudentId,
                    request.Name,
                    request.Description,
                    request.Category,
                    request.Items ?? []);

                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    id => Results.Created($"/api/v1/workouts/{id}", new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Workouts)
            .WithName("CreateWorkout")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.write");
    }
}
