using Application.Abstractions.Messaging;
using Application.Students;
using Application.Students.List;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Students;

internal sealed class ListStudentsEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("students", async (
                IQueryHandler<ListStudentsQuery, IReadOnlyCollection<StudentListItemResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new ListStudentsQuery(), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Students)
            .WithName("ListStudents")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}student.read");
    }
}
