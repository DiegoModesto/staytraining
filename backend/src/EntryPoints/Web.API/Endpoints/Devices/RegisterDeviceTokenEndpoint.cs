using Application.Abstractions.Messaging;
using Application.Devices.Register;
using Domain.Devices;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Devices;

internal sealed class RegisterDeviceTokenEndpoint : IEndpoint
{
    public sealed record Request(string Token, DevicePlatform Platform);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("devices/token", async (
                Request request,
                ICommandHandler<RegisterDeviceTokenCommand, Guid> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(
                    new RegisterDeviceTokenCommand(request.Token, request.Platform), cancellationToken);

                return result.Match(
                    id => Results.Ok(new { id }),
                    CustomResults.Problem);
            })
            .WithTags(Tags.Devices)
            .WithName("RegisterDeviceToken")
            .RequireAuthorization();
    }
}
