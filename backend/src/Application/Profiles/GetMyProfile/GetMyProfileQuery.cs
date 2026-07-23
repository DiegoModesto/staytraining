using Application.Abstractions.Messaging;

namespace Application.Profiles.GetMyProfile;

public sealed record GetMyProfileQuery : IQuery<ProfileResponse>;
