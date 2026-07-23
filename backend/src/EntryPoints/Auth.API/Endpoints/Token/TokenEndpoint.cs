using System.Diagnostics;
using System.Security.Claims;
using System.Text.Json;
using Auth.API.Telemetry;
using Auth.Application.Abstractions.Data;
using Auth.Application.Abstractions.Identity;
using Auth.Application.Abstractions.Messaging;
using Auth.Application.M2MClients.Authenticate;
using Auth.Domain.Audit;
using Auth.Domain.Users;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using OpenIddict.Abstractions;
using OpenIddict.Server.AspNetCore;

namespace Auth.API.Endpoints.Token;

internal sealed class TokenEndpoint : IEndpoint
{
    private const int MaxUserAgentLength = 500;
    private const int MaxIpLength = 45;

    private static string Truncate(string s, int max) => s.Length > max ? s[..max] : s;

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("/connect/token", TokenAsync);
    }

    private static async Task<IResult> TokenAsync(
        HttpContext http,
        ICommandHandler<AuthenticateM2MClientCommand, M2MClientAuthenticated> authenticateM2M,
        IPermissionResolver permissions,
        IUserPasswordHasher passwordHasher,
        IAuthDbContext db,
        CancellationToken ct)
    {
        OpenIddictRequest request = http.GetOpenIddictServerRequest()
            ?? throw new InvalidOperationException("OpenIddict server request not available.");

        if (request.IsAuthorizationCodeGrantType() || request.IsRefreshTokenGrantType())
        {
            AuthenticateResult info = await http.AuthenticateAsync(
                OpenIddictServerAspNetCoreDefaults.AuthenticationScheme);

            if (info.Principal is null)
            {
                return Results.Forbid();
            }

            if (request.IsRefreshTokenGrantType())
            {
                string? subStr = info.Principal.FindFirstValue(OpenIddictConstants.Claims.Subject);
                string? tenantStr = info.Principal.FindFirstValue("tenant_id");

                if (Guid.TryParse(subStr, out Guid userId)
                 && Guid.TryParse(tenantStr, out Guid tenantId)
                 && info.Principal.Identity is ClaimsIdentity ci)
                {
                    var permsR = await permissions.ResolveAsync(tenantId, userId, ct);
                    if (permsR.IsSuccess)
                    {
                        Claim[] oldPerms = ci.FindAll("permission").ToArray();
                        foreach (Claim p in oldPerms)
                        {
                            ci.RemoveClaim(p);
                        }

                        foreach (string p in permsR.Value)
                        {
                            var c = new Claim("permission", p);
                            c.SetDestinations(
                                OpenIddictConstants.Destinations.AccessToken,
                                OpenIddictConstants.Destinations.IdentityToken);
                            ci.AddClaim(c);
                        }
                    }
                }
            }

            return Results.SignIn(
                info.Principal,
                authenticationScheme: OpenIddictServerAspNetCoreDefaults.AuthenticationScheme);
        }

        if (request.IsClientCredentialsGrantType())
        {
            using Activity? activity = AuthActivitySource.Instance.StartActivity("TokenClientCredentials");
            activity?.SetTag("client.id", request.ClientId);

            if (string.IsNullOrEmpty(request.ClientId) || string.IsNullOrEmpty(request.ClientSecret))
            {
                return Results.Forbid();
            }

            var clientR = await authenticateM2M.Handle(
                new AuthenticateM2MClientCommand(request.ClientId, request.ClientSecret), ct);
            if (clientR.IsFailure)
            {
                return Results.Forbid();
            }

            activity?.SetTag("tenant.id", clientR.Value.TenantId);

            var identity = new ClaimsIdentity(
                OpenIddictServerAspNetCoreDefaults.AuthenticationScheme,
                OpenIddictConstants.Claims.Name,
                OpenIddictConstants.Claims.Role);

            identity.AddClaim(new Claim(OpenIddictConstants.Claims.Subject, request.ClientId));
            identity.AddClaim(new Claim("tenant_id", clientR.Value.TenantId.ToString()));

            string[] requestedScopes = request.GetScopes().ToArray();
            string[] allowed = clientR.Value.AllowedScopes
                .Intersect(requestedScopes, StringComparer.Ordinal)
                .ToArray();

            foreach (Claim claim in identity.Claims)
            {
                claim.SetDestinations(OpenIddictConstants.Destinations.AccessToken);
            }

            var principal = new ClaimsPrincipal(identity);
            principal.SetScopes(allowed);

            string ip = Truncate(http.Connection.RemoteIpAddress?.ToString() ?? string.Empty, MaxIpLength);
            string userAgent = Truncate(http.Request.Headers.UserAgent.ToString(), MaxUserAgentLength);
            db.AuditEvents.Add(AuthAuditEvent.Record(
                clientR.Value.TenantId,
                userId: null,
                AuthAuditEventType.M2MTokenIssued,
                ip,
                userAgent,
                detail: JsonSerializer.Serialize(new { client_id = request.ClientId })));
            await db.SaveChangesAsync(ct);

            return Results.SignIn(
                principal,
                authenticationScheme: OpenIddictServerAspNetCoreDefaults.AuthenticationScheme);
        }

        if (request.IsPasswordGrantType())
        {
            using Activity? activity = AuthActivitySource.Instance.StartActivity("TokenPassword");

            string ip = Truncate(http.Connection.RemoteIpAddress?.ToString() ?? string.Empty, MaxIpLength);
            string userAgent = Truncate(http.Request.Headers.UserAgent.ToString(), MaxUserAgentLength);

            string email = (request.Username ?? string.Empty).Trim().ToLowerInvariant();
            string password = request.Password ?? string.Empty;

            User? user = string.IsNullOrEmpty(email)
                ? null
                : await db.Users.FirstOrDefaultAsync(
                    u => u.Email.ToLower() == email && u.IsActive && u.PasswordHash != null, ct);

            if (user is null || !passwordHasher.Verify(password, user.PasswordHash!))
            {
                db.AuditEvents.Add(AuthAuditEvent.Record(
                    user?.TenantId ?? Guid.Empty, user?.Id,
                    AuthAuditEventType.LoginFailed, ip, userAgent,
                    JsonSerializer.Serialize(new { reason = "invalid_credentials", email })));
                await db.SaveChangesAsync(ct);

                return Results.Json(
                    new OpenIddictResponse
                    {
                        Error = OpenIddictConstants.Errors.InvalidGrant,
                        ErrorDescription = "E-mail ou senha inválidos.",
                    },
                    statusCode: StatusCodes.Status400BadRequest);
            }

            activity?.SetTag("tenant.id", user.TenantId);
            activity?.SetTag("user.id", user.Id);

            var permsR = await permissions.ResolveAsync(user.TenantId, user.Id, ct);
            IReadOnlyCollection<string> perms = permsR.IsSuccess ? permsR.Value : [];

            var identity = new ClaimsIdentity(
                OpenIddictServerAspNetCoreDefaults.AuthenticationScheme,
                OpenIddictConstants.Claims.Name,
                OpenIddictConstants.Claims.Role);

            identity.AddClaim(new Claim(OpenIddictConstants.Claims.Subject, user.Id.ToString()));
            identity.AddClaim(new Claim("tenant_id", user.TenantId.ToString()));
            identity.AddClaim(new Claim(OpenIddictConstants.Claims.Email, user.Email));
            identity.AddClaim(new Claim(OpenIddictConstants.Claims.Name, user.DisplayName));
            foreach (string p in perms)
            {
                identity.AddClaim(new Claim("permission", p));
            }

            foreach (Claim claim in identity.Claims)
            {
                claim.SetDestinations(
                    OpenIddictConstants.Destinations.AccessToken,
                    OpenIddictConstants.Destinations.IdentityToken);
            }

            var principal = new ClaimsPrincipal(identity);
            System.Collections.Immutable.ImmutableArray<string> scopes = request.GetScopes();
            principal.SetScopes(scopes);

            // Same audience/resource union as AuthorizeEndpoint so the token validates at the
            // resource servers AND introspects as active.
            if (scopes.Contains("api:web"))
            {
                principal.SetResources("api:web", "api:auth", "web-api", "gateway");
            }

            db.AuditEvents.Add(AuthAuditEvent.Record(
                user.TenantId, user.Id, AuthAuditEventType.LoginSucceeded, ip, userAgent,
                JsonSerializer.Serialize(new { email = user.Email, grant = "password" })));
            await db.SaveChangesAsync(ct);

            return Results.SignIn(
                principal,
                authenticationScheme: OpenIddictServerAspNetCoreDefaults.AuthenticationScheme);
        }

        return Results.Json(
            new OpenIddictResponse { Error = OpenIddictConstants.Errors.UnsupportedGrantType },
            statusCode: StatusCodes.Status400BadRequest);
    }
}
