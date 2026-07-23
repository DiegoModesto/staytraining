using Application.Abstractions.Messaging;
using Application.Profiles.Update;
using Domain.Profiles;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Profiles;

internal sealed class UpdateMyProfileEndpoint : IEndpoint
{
    public sealed record Request(
        string FullName,
        string Email,
        string? Phone,
        string? EmergencyPhone,
        BloodType BloodType,
        int? HeightCm,
        decimal? WeightKg);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPut("profiles/me", async (
                Request request,
                ICommandHandler<UpdateMyProfileCommand> handler,
                CancellationToken cancellationToken) =>
            {
                var command = new UpdateMyProfileCommand(
                    request.FullName, request.Email, request.Phone, request.EmergencyPhone,
                    request.BloodType, request.HeightCm, request.WeightKg);
                var result = await handler.Handle(command, cancellationToken);

                return result.Match(() => Results.NoContent(), CustomResults.Problem);
            })
            .WithTags(Tags.Profiles)
            .WithName("UpdateMyProfile")
            .RequireAuthorization();
    }
}
