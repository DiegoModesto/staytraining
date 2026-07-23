namespace Application.Abstractions.Authentication;

public interface IUserContext
{
    Guid UserId { get; }
    Guid? TenantId { get; }
    bool IsAuthenticated { get; }

    /// <summary>Display name of the current user (from the <c>name</c>/<c>preferred_username</c> claim), if present.</summary>
    string? Name { get; }

    /// <summary>True when the current user carries the given <c>permission</c> claim.</summary>
    bool HasPermission(string permission);
}
