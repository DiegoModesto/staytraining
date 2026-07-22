using System.Text.Encodings.Web;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.Extensions.Options;

namespace Auth.API.Authentication;

/// <summary>
/// Development-only stand-in for the Entra OIDC handler, registered under the same scheme name
/// (<see cref="EntraAuthenticationExtensions.SchemeName"/>) so <c>AuthorizeEndpoint</c> works
/// unchanged. Instead of redirecting to Microsoft Entra it sends the user to the local
/// <c>/dev-login</c> page; that page signs a mock identity into the cookie scheme, which this
/// handler then reads back on the next <c>AuthenticateAsync("Entra")</c> call.
/// </summary>
internal sealed class DevEntraAuthenticationHandler(
    IOptionsMonitor<AuthenticationSchemeOptions> options,
    ILoggerFactory logger,
    UrlEncoder encoder)
    : AuthenticationHandler<AuthenticationSchemeOptions>(options, logger, encoder)
{
    internal const string DevLoginPath = "/dev-login";

    protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
    {
        AuthenticateResult cookie =
            await Context.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);

        if (!cookie.Succeeded || cookie.Principal is null)
        {
            return AuthenticateResult.NoResult();
        }

        return AuthenticateResult.Success(
            new AuthenticationTicket(cookie.Principal, Scheme.Name));
    }

    protected override Task HandleChallengeAsync(AuthenticationProperties properties)
    {
        string returnUrl = properties.RedirectUri ?? "/";
        Response.Redirect($"{DevLoginPath}?returnUrl={Uri.EscapeDataString(returnUrl)}");
        return Task.CompletedTask;
    }
}
