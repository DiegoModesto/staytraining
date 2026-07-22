using Application.Abstractions.Messaging;
using Application.Exercises;
using Application.Exercises.GetById;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Exercises;

internal sealed class GetExerciseByIdEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("exercises/{id:guid}", async (
                Guid id,
                IQueryHandler<GetExerciseByIdQuery, ExerciseResponse> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new GetExerciseByIdQuery(id), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Exercises)
            .WithName("GetExerciseById")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}exercise.read");
    }
}
