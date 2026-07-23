using Application.Abstractions.Messaging;
using Application.Students;
using Application.Students.ListNotes;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Students;

internal sealed class ListStudentNotesEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("students/{id:guid}/notes", async (
                Guid id,
                IQueryHandler<ListStudentNotesQuery, IReadOnlyCollection<StudentNoteResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new ListStudentNotesQuery(id), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Students)
            .WithName("ListStudentNotes")
            // student.read is a professor-only permission — students never receive it, so annotations stay internal.
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}student.read");
    }
}
