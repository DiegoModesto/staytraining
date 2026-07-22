using Application.Abstractions.Messaging;
using Application.Execution;
using Application.Execution.Notes.GetSessionNotes;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Notes;

internal sealed class GetSessionNotesEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("sessions/{id:guid}/notes", async (
                Guid id,
                IQueryHandler<GetSessionNotesQuery, IReadOnlyCollection<ExerciseNoteResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new GetSessionNotesQuery(id), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Notes)
            .WithName("GetSessionNotes")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}workout.read");
    }
}
