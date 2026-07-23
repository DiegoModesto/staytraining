using Application.Abstractions.Authentication;
using Application.Abstractions.Messaging;
using Application.Abstractions.Storage;
using Application.Profiles.SetPhoto;
using Domain.Profiles;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Profiles;

internal sealed class UploadMyProfilePhotoEndpoint : IEndpoint
{
    private const long MaxBytes = 2 * 1024 * 1024; // 2 MB — the client already crops+resizes.

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("profiles/me/photo", async (
                IFormFile file,
                IUserContext userContext,
                IFileStorage storage,
                ICommandHandler<SetMyProfilePhotoCommand> handler,
                CancellationToken cancellationToken) =>
            {
                if (file.Length == 0 || file.Length > MaxBytes
                    || !file.ContentType.StartsWith("image/", StringComparison.OrdinalIgnoreCase))
                {
                    return CustomResults.Problem(SharedKernel.Result.Failure(ProfileErrors.PhotoInvalid));
                }

                Guid tenantId = userContext.TenantId
                    ?? throw new InvalidOperationException("TenantId is required to upload a profile photo.");
                string extension = Path.GetExtension(file.FileName);
                if (string.IsNullOrWhiteSpace(extension))
                {
                    extension = ".webp";
                }

                // Stable key per user so a re-upload overwrites the previous photo (one image per profile).
                string key = $"avatars/{tenantId:N}/{userContext.UserId:N}{extension}";

                await using (Stream stream = file.OpenReadStream())
                {
                    await storage.UploadAsync(key, stream, file.ContentType, file.Length, cancellationToken);
                }

                var result = await handler.Handle(new SetMyProfilePhotoCommand(key), cancellationToken);
                if (result.IsFailure)
                {
                    return CustomResults.Problem(result);
                }

                string url = await storage.GetPresignedUrlAsync(key, TimeSpan.FromHours(1), cancellationToken);
                return Results.Ok(new { key, photoUrl = url });
            })
            .WithTags(Tags.Profiles)
            .WithName("UploadMyProfilePhoto")
            .DisableAntiforgery()
            .RequireAuthorization();
    }
}
