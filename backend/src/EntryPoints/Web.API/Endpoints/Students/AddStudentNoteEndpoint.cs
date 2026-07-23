using Application.Abstractions.Messaging;
using Application.Students.AddStudentNote;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Students;

internal sealed class AddStudentNoteEndpoint : IEndpoint
{
    public sealed record Request(string Content);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("students/{id:guid}/notes", async (
                Guid id,
                Request request,
                ICommandHandler<AddStudentNoteCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new AddStudentNoteCommand(id, request.Content);

                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    noteId => Results.Created($"/api/v1/students/{id}/notes/{noteId}", new { id = noteId }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Students)
            .WithName("AddStudentNote")
            // Reuses health.write: a professor-only permission that is already granted/seeded, so
            // annotations work without provisioning a brand-new permission on existing roles.
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}health.write");
    }
}
