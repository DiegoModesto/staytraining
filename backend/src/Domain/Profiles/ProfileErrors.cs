using SharedKernel;

namespace Domain.Profiles;

public static class ProfileErrors
{
    public static readonly Error NotFound =
        Error.NotFound("Profile.NotFound", "Profile was not found.");

    public static readonly Error PhotoInvalid =
        Error.Validation("Profile.PhotoInvalid", "The photo must be an image file up to 2 MB.");
}
