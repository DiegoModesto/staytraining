using Application.Abstractions.Messaging;
using Application.Execution;
using Application.Execution.Notes.GetAllNotes;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Notes;

internal sealed class GetAllNotesEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("notes", async (
                Guid? studentId,
                Guid? exerciseId,
                IQueryHandler<GetAllNotesQuery, IReadOnlyCollection<ExerciseNoteResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new GetAllNotesQuery(studentId, exerciseId), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Notes)
            .WithName("GetAllNotes")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}report.read");
    }
}
