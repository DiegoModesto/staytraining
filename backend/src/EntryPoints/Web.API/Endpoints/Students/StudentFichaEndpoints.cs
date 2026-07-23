using Application.Abstractions.Messaging;
using Application.Students;
using Application.Students.EditLogs;
using Application.Students.Ficha;
using Domain.Profiles;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Students;

// Admin editing of a student's ficha — all audited. Gated by studentficha.write.
file static class FichaPolicy
{
    public const string Gate = "studentficha.write";
}

internal sealed class UpdateStudentFichaEndpoint : IEndpoint
{
    public sealed record Request(
        string FullName, string? Email, string? Phone, string? EmergencyPhone,
        BloodType BloodType, int? HeightCm, decimal? WeightKg, string? Goals);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPut("students/{id:guid}/ficha", async (
                Guid id,
                Request request,
                ICommandHandler<UpdateStudentFichaCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new UpdateStudentFichaCommand(
                    id, request.FullName, request.Email, request.Phone, request.EmergencyPhone,
                    request.BloodType, request.HeightCm, request.WeightKg, request.Goals);
                var result = await handler.Handle(command, cancellationToken);
                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Students)
            .WithName("UpdateStudentFicha")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}{FichaPolicy.Gate}");
    }
}

internal sealed class AddStudentApportmentEndpoint : IEndpoint
{
    public sealed record Request(Guid BodyPartId, Guid ProblemTypeId, string? Observation);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("students/{id:guid}/apportments", async (
                Guid id,
                Request request,
                ICommandHandler<AddStudentApportmentCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new AddStudentApportmentCommand(id, request.BodyPartId, request.ProblemTypeId, request.Observation);
                var result = await handler.Handle(command, cancellationToken);
                return result.Match(
                    apportmentId => Results.Created($"/api/v1/students/{id}/apportments/{apportmentId}", new { id = apportmentId }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Students)
            .WithName("AddStudentApportment")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}{FichaPolicy.Gate}");
    }
}

internal sealed class RemoveStudentApportmentEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapDelete("students/{id:guid}/apportments/{apportmentId:guid}", async (
                Guid id,
                Guid apportmentId,
                ICommandHandler<RemoveStudentApportmentCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new RemoveStudentApportmentCommand(id, apportmentId), cancellationToken);
                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Students)
            .WithName("RemoveStudentApportment")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}{FichaPolicy.Gate}");
    }
}

internal sealed class ListStudentEditLogsEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("students/{id:guid}/edit-logs", async (
                Guid id,
                IQueryHandler<ListStudentEditLogsQuery, IReadOnlyCollection<StudentEditLogResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new ListStudentEditLogsQuery(id), cancellationToken);
                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Students)
            .WithName("ListStudentEditLogs")
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}{FichaPolicy.Gate}");
    }
}
