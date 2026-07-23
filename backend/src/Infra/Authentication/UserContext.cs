using System.Security.Claims;
using Application.Abstractions.Authentication;
using Microsoft.AspNetCore.Http;

namespace Infra.Authentication;

internal sealed class UserContext(IHttpContextAccessor httpContextAccessor) : IUserContext
{
    public Guid UserId
    {
        get
        {
            // OpenIddict introspection surfaces the subject as the standard "sub" claim; it does
            // not remap it to the legacy ClaimTypes.NameIdentifier. Accept either so tokens issued
            // by Auth.API (sub) and any legacy/JWT path (NameIdentifier) both resolve.
            ClaimsPrincipal? user = httpContextAccessor.HttpContext?.User;
            string? userId = user?.FindFirstValue("sub")
                ?? user?.FindFirstValue(ClaimTypes.NameIdentifier);

            return Guid.TryParse(userId, out Guid id)
                ? id
                : throw new InvalidClaimException("User id is unavailable");
        }
    }

    public Guid? TenantId
    {
        get
        {
            HttpContext? httpContext = httpContextAccessor.HttpContext;
            if (httpContext is null)
            {
                return null;
            }

            string? claim = httpContext.User.FindFirstValue("tenant_id");
            if (Guid.TryParse(claim, out Guid fromClaim))
            {
                return fromClaim;
            }

            string? header = httpContext.Request.Headers["X-Forwarded-TenantId"].FirstOrDefault();
            return Guid.TryParse(header, out Guid fromHeader) ? fromHeader : null;
        }
    }

    public bool IsAuthenticated =>
        httpContextAccessor.HttpContext?.User.Identity?.IsAuthenticated ?? false;

    public string? Name
    {
        get
        {
            ClaimsPrincipal? user = httpContextAccessor.HttpContext?.User;
            return user?.FindFirstValue("name")
                ?? user?.FindFirstValue("preferred_username");
        }
    }

    public bool HasPermission(string permission)
    {
        ClaimsPrincipal? user = httpContextAccessor.HttpContext?.User;
        return user is not null
            && user.Claims.Any(c => c.Type == "permission" && c.Value == permission);
    }
}
