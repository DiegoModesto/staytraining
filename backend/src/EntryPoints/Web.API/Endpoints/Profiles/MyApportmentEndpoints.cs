using Application.Abstractions.Messaging;
using Application.Students.Apportments;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Profiles;

internal sealed class AddMyApportmentEndpoint : IEndpoint
{
    public sealed record Request(Guid BodyPartId, Guid ProblemTypeId, string? Observation);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("profiles/me/apportments", async (
                Request request,
                ICommandHandler<AddMyApportmentCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new AddMyApportmentCommand(request.BodyPartId, request.ProblemTypeId, request.Observation);
                var result = await handler.Handle(command, cancellationToken);
                return result.Match(
                    id => Results.Created($"/api/v1/profiles/me/apportments/{id}", new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Profiles)
            .WithName("AddMyApportment")
            .RequireAuthorization();
    }
}

internal sealed class RemoveMyApportmentEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapDelete("profiles/me/apportments/{id:guid}", async (
                Guid id,
                ICommandHandler<RemoveMyApportmentCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new RemoveMyApportmentCommand(id), cancellationToken);
                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Profiles)
            .WithName("RemoveMyApportment")
            .RequireAuthorization();
    }
}
