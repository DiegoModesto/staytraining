using Application.Abstractions.Messaging;
using Application.Exercises.List;
using Domain.Exercises;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Exercises;

internal sealed class ListExercisesEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("exercises", async (
                ExerciseCategory? category,
                IQueryHandler<ListExercisesQuery, IReadOnlyCollection<ExerciseListItemResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new ListExercisesQuery(category), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Exercises)
            .WithName("ListExercises")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}exercise.read");
    }
}
