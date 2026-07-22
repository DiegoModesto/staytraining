using Application.Abstractions.Messaging;
using Application.Execution.Sessions.UpsertNote;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Sessions;

internal sealed class UpsertExerciseNoteEndpoint : IEndpoint
{
    public sealed record Request(
        Guid WorkoutItemId,
        Guid ExerciseId,
        decimal? LoadKg,
        bool PainFlag,
        string? PainNote,
        string? Comment,
        int? PerformedSets,
        int? PerformedReps);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPut("sessions/{id:guid}/notes", async (
                Guid id,
                Request request,
                ICommandHandler<UpsertExerciseNoteCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new UpsertExerciseNoteCommand(
                    id,
                    request.WorkoutItemId,
                    request.ExerciseId,
                    request.LoadKg,
                    request.PainFlag,
                    request.PainNote,
                    request.Comment,
                    request.PerformedSets,
                    request.PerformedReps);

                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    noteId => Results.Ok(new { id = noteId }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Sessions)
            .WithName("UpsertExerciseNote")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}note.write");
    }
}
