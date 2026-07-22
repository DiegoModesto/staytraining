using Microsoft.AspNetCore.Authentication;

namespace Auth.API.Authentication;

internal static class DevEntraAuthenticationExtensions
{
    /// <summary>
    /// Registers the Development-only <c>"Entra"</c> stand-in scheme so the OpenIddict authorize
    /// flow works with the local <c>/dev-login</c> page instead of Microsoft Entra. Only call this
    /// in Development and only when real Entra is NOT configured — otherwise the dev login would be
    /// a hard authentication bypass.
    /// </summary>
    public static IServiceCollection AddDevEntraLogin(this IServiceCollection services)
    {
        services.AddAuthentication()
            .AddScheme<AuthenticationSchemeOptions, DevEntraAuthenticationHandler>(
                EntraAuthenticationExtensions.SchemeName, displayName: null, configureOptions: null);

        return services;
    }
}
