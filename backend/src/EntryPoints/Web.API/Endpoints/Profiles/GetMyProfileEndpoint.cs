using Application.Abstractions.Messaging;
using Application.Profiles;
using Application.Profiles.GetMyProfile;
using Web.API.Extensions;
using Web.API.Infrastructure;

namespace Web.API.Endpoints.Profiles;

internal sealed class GetMyProfileEndpoint : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("profiles/me", async (
                IQueryHandler<GetMyProfileQuery, ProfileResponse> handler,
                CancellationToken cancellationToken) =>
            {
                var result = await handler.Handle(new GetMyProfileQuery(), cancellationToken);
                return result.Match(Results.Ok, CustomResults.Problem);
            })
            .WithTags(Tags.Profiles)
            .WithName("GetMyProfile")
            .RequireAuthorization();
    }
}
