using Application.Abstractions.Messaging;
using Application.HealthCatalog;
using Application.HealthCatalog.BodyParts;
using Application.HealthCatalog.List;
using Application.HealthCatalog.ProblemTypes;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.HealthCatalog;

file static class Policy
{
    public const string Read = "healthcatalog.read";
    public const string Write = "healthcatalog.write";
    public static string Gate(string code) => $"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}{code}";
}

internal sealed class ListHealthCatalogEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("health-catalog", async (
                IQueryHandler<ListHealthCatalogQuery, IReadOnlyCollection<BodyPartResponse>> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new ListHealthCatalogQuery(), cancellationToken);
                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.HealthCatalog)
            .WithName("ListHealthCatalog")
            .RequireAuthorization(Policy.Gate(Policy.Read));
    }
}

internal sealed class CreateBodyPartEndpoint : IEndpoint
{
    public sealed record Request(string Name);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("health-catalog/body-parts", async (
                Request request,
                ICommandHandler<CreateBodyPartCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new CreateBodyPartCommand(request.Name), cancellationToken);
                return result.Match(id => Results.Created($"/api/v1/health-catalog/body-parts/{id}", new { id }), CustomResults.Problem);
            })
            .WithTags(Tags.HealthCatalog).WithName("CreateBodyPart")
            .RequireAuthorization(Policy.Gate(Policy.Write));
    }
}

internal sealed class UpdateBodyPartEndpoint : IEndpoint
{
    public sealed record Request(string Name);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPut("health-catalog/body-parts/{id:guid}", async (
                Guid id,
                Request request,
                ICommandHandler<UpdateBodyPartCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new UpdateBodyPartCommand(id, request.Name), cancellationToken);
                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.HealthCatalog).WithName("UpdateBodyPart")
            .RequireAuthorization(Policy.Gate(Policy.Write));
    }
}

internal sealed class DeleteBodyPartEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapDelete("health-catalog/body-parts/{id:guid}", async (
                Guid id,
                ICommandHandler<DeleteBodyPartCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new DeleteBodyPartCommand(id), cancellationToken);
                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.HealthCatalog).WithName("DeleteBodyPart")
            .RequireAuthorization(Policy.Gate(Policy.Write));
    }
}

internal sealed class CreateProblemTypeEndpoint : IEndpoint
{
    public sealed record Request(Guid BodyPartId, string Name);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("health-catalog/problem-types", async (
                Request request,
                ICommandHandler<CreateProblemTypeCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new CreateProblemTypeCommand(request.BodyPartId, request.Name), cancellationToken);
                return result.Match(id => Results.Created($"/api/v1/health-catalog/problem-types/{id}", new { id }), CustomResults.Problem);
            })
            .WithTags(Tags.HealthCatalog).WithName("CreateProblemType")
            .RequireAuthorization(Policy.Gate(Policy.Write));
    }
}

internal sealed class UpdateProblemTypeEndpoint : IEndpoint
{
    public sealed record Request(string Name);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPut("health-catalog/problem-types/{id:guid}", async (
                Guid id,
                Request request,
                ICommandHandler<UpdateProblemTypeCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new UpdateProblemTypeCommand(id, request.Name), cancellationToken);
                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.HealthCatalog).WithName("UpdateProblemType")
            .RequireAuthorization(Policy.Gate(Policy.Write));
    }
}

internal sealed class DeleteProblemTypeEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapDelete("health-catalog/problem-types/{id:guid}", async (
                Guid id,
                ICommandHandler<DeleteProblemTypeCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new DeleteProblemTypeCommand(id), cancellationToken);
                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.HealthCatalog).WithName("DeleteProblemType")
            .RequireAuthorization(Policy.Gate(Policy.Write));
    }
}
