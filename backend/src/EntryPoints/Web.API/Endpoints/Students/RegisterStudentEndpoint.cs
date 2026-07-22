using Application.Abstractions.Messaging;
using Application.Students.Register;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Students;

internal sealed class RegisterStudentEndpoint : IEndpoint
{
    public sealed record Request(Guid UserId, string FullName, string? Email, DateOnly? BirthDate, string? Goals);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("students", async (
                Request request,
                ICommandHandler<RegisterStudentCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new RegisterStudentCommand(
                    request.UserId, request.FullName, request.Email, request.BirthDate, request.Goals);

                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    id => Results.Created($"/api/v1/students/{id}", new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Students)
            .WithName("RegisterStudent")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}student.manage");
    }
}
