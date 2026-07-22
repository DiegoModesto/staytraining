using Application.Abstractions.Messaging;
using Application.Students;
using Application.Students.GetById;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Students;

internal sealed class GetStudentByIdEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("students/{id:guid}", async (
                Guid id,
                IQueryHandler<GetStudentByIdQuery, StudentDetailResponse> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new GetStudentByIdQuery(id), cancellationToken);

                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Students)
            .WithName("GetStudentById")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}student.read");
    }
}
