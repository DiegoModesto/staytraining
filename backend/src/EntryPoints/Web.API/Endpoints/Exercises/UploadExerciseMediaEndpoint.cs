using Application.Abstractions.Messaging;
using Application.Abstractions.Storage;
using Application.Exercises.AddMedia;
using Domain.Exercises;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Exercises;

internal sealed class UploadExerciseMediaEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("exercises/{id:guid}/media", async (
                Guid id,
                IFormFile file,
                ExerciseMediaKind kind,
                IFileStorage storage,
                ICommandHandler<AddExerciseMediaCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                string extension = Path.GetExtension(file.FileName);
                string key = $"exercises/{id}/{Guid.NewGuid():N}{extension}";
                string contentType = string.IsNullOrWhiteSpace(file.ContentType)
                    ? "application/octet-stream"
                    : file.ContentType;

                await using (Stream stream = file.OpenReadStream())
                {
                    await storage.UploadAsync(key, stream, contentType, file.Length, cancellationToken);
                }

                var command = new AddExerciseMediaCommand(id, kind, key, null, contentType, file.Length);
                var result = await handler.Handle(command, cancellationToken);

                return result.Match(
                    mediaId => Results.Created($"/api/v1/exercises/{id}/media/{mediaId}", new { id = mediaId, key }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Exercises)
            .WithName("UploadExerciseMedia")
            .DisableAntiforgery()
            .RequireAuthorization($"{Infra.Authorization.PermissionPolicyProvider.PolicyPrefix}exercise.write");
    }
}
