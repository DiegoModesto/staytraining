using Application.Abstractions.Messaging;
using Application.Exercises;
using Application.Exercises.Create;
using Domain.Exercises;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Exercises;

internal sealed class CreateExerciseEndpoint : IEndpoint
{
    public sealed record Request(
        string Name,
        string? Description,
        ExerciseCategory Category,
        Guid PrimaryMuscleGroupId,
        IReadOnlyCollection<Guid>? SecondaryMuscleGroupIds,
        string? UsageExample,
        int DefaultSets,
        int DefaultReps,
        int DefaultRestSeconds,
        bool IsAerobic,
        int? DefaultWorkSeconds,
        int? DefaultIntervalRestSeconds,
        int? DefaultRounds,
        IReadOnlyCollection<ExerciseMediaInput>? Media);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("exercises", async (
                Request request,
                ICommandHandler<CreateExerciseCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new CreateExerciseCommand(
                    request.Name,
                    request.Description,
                    request.Category,
                    request.PrimaryMuscleGroupId,
                    request.SecondaryMuscleGroupIds,
                    request.UsageExample,
                    request.DefaultSets,
                    request.DefaultReps,
                    request.DefaultRestSeconds,
                    request.IsAerobic,
                    request.DefaultWorkSeconds,
                    request.DefaultIntervalRestSeconds,
                    request.DefaultRounds,
                    request.Media);

                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    id => Results.Created($"/api/v1/exercises/{id}", new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Exercises)
            .WithName("CreateExercise")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}exercise.write");
    }
}
