using System.Security.Claims;
using System.Text;
using Auth.API.Authentication;
using Auth.Infra.Database;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;

namespace Auth.API.Endpoints.DevLogin;

/// <summary>
/// Development-only local login. Mapped by <c>Program.cs</c> only when the app is in Development and
/// real Entra is not configured — never via the <c>IEndpoint</c> auto-registration, so it can never
/// leak into a production build. Lets you pick a mock identity (see <see cref="DevIdentityDefaults"/>),
/// signs it into the cookie scheme with the <c>tid/oid/preferred_username/name</c> claims the
/// <c>AuthorizeEndpoint</c> expects, then returns to the OpenIddict authorize request.
/// </summary>
internal static class DevLoginEndpoints
{
    public static void Map(IEndpointRouteBuilder app)
    {
        app.MapGet(DevEntraAuthenticationHandler.DevLoginPath, (string? returnUrl) =>
                Results.Content(RenderPage(returnUrl), "text/html; charset=utf-8"))
            .AllowAnonymous()
            .ExcludeFromDescription();

        app.MapPost(DevEntraAuthenticationHandler.DevLoginPath, async (
                HttpContext http,
                [FromForm] string oid,
                [FromForm] string? password,
                [FromForm] string? returnUrl) =>
            {
                DevIdentityDefaults.DevUser? mock =
                    DevIdentityDefaults.All.FirstOrDefault(u => u.EntraOid.ToString() == oid);
                if (mock is null)
                {
                    return Results.BadRequest("Unknown mock user.");
                }

                // Dev-only password gate (no real credential store — production uses Entra).
                if (!string.Equals(password, DevIdentityDefaults.DevPassword, StringComparison.Ordinal))
                {
                    return Results.Content(
                        RenderPage(returnUrl, $"Senha incorreta para {mock.Email}."),
                        "text/html; charset=utf-8");
                }

                var identity = new ClaimsIdentity(
                    authenticationType: CookieAuthenticationDefaults.AuthenticationScheme,
                    nameType: "name",
                    roleType: "roles");
                identity.AddClaim(new Claim("tid", DevIdentityDefaults.TenantId.ToString()));
                identity.AddClaim(new Claim("oid", mock.EntraOid.ToString()));
                identity.AddClaim(new Claim("preferred_username", mock.Email));
                identity.AddClaim(new Claim("name", mock.DisplayName));

                await http.SignInAsync(
                    CookieAuthenticationDefaults.AuthenticationScheme,
                    new ClaimsPrincipal(identity));

                // Only ever redirect back into this app (avoid an open-redirect via returnUrl).
                string target = !string.IsNullOrEmpty(returnUrl) && returnUrl.StartsWith('/')
                    ? returnUrl
                    : "/";
                return Results.Redirect(target);
            })
            .AllowAnonymous()
            .DisableAntiforgery()
            .ExcludeFromDescription();
    }

    private static string RenderPage(string? returnUrl, string? error = null)
    {
        string safeReturn = System.Net.WebUtility.HtmlEncode(returnUrl ?? string.Empty);

        var sb = new StringBuilder();
        sb.Append("""
            <!doctype html><html lang="pt-br"><head><meta charset="utf-8">
            <meta name="viewport" content="width=device-width,initial-scale=1">
            <title>Dev Login — StayTraining</title>
            <style>
              body{font-family:system-ui,sans-serif;background:#0f172a;color:#e2e8f0;display:flex;
                   min-height:100vh;align-items:center;justify-content:center;margin:0}
              .card{background:#1e293b;padding:2rem 2.5rem;border-radius:12px;max-width:420px;width:100%;
                    box-shadow:0 10px 40px rgba(0,0,0,.4)}
              h1{font-size:1.25rem;margin:0 0 .25rem}
              p{color:#94a3b8;margin:0 0 1.5rem;font-size:.9rem}
              button{display:block;width:100%;text-align:left;padding:.9rem 1rem;margin:.5rem 0;
                     border:1px solid #334155;border-radius:8px;background:#0f172a;color:#e2e8f0;
                     cursor:pointer;font-size:1rem}
              button:hover{border-color:#3b82f6;background:#172033}
              .role{color:#60a5fa;font-size:.8rem}
              .warn{margin-top:1.5rem;font-size:.75rem;color:#f59e0b}
              input[type=password]{width:100%;box-sizing:border-box;padding:.7rem 1rem;margin:.75rem 0 .25rem;
                   border:1px solid #334155;border-radius:8px;background:#0f172a;color:#e2e8f0;font-size:1rem}
              .err{background:#7f1d1d;color:#fecaca;padding:.6rem .9rem;border-radius:8px;font-size:.85rem;margin-bottom:1rem}
            </style></head><body><div class="card">
            <h1>Login local (Development)</h1>
            <p>Sem Microsoft Entra. Informe a senha e escolha uma identidade mock para continuar o fluxo OpenIddict.</p>
            """);

        if (!string.IsNullOrEmpty(error))
        {
            sb.Append($"""<div class="err">{System.Net.WebUtility.HtmlEncode(error)}</div>""");
        }

        foreach (DevIdentityDefaults.DevUser u in DevIdentityDefaults.All)
        {
            sb.Append(
                $"""
                <form method="post" action="{DevEntraAuthenticationHandler.DevLoginPath}">
                  <input type="hidden" name="oid" value="{u.EntraOid}">
                  <input type="hidden" name="returnUrl" value="{safeReturn}">
                  <input type="password" name="password" placeholder="Senha" required autocomplete="current-password">
                  <button type="submit">{System.Net.WebUtility.HtmlEncode(u.DisplayName)}
                    <div class="role">{System.Net.WebUtility.HtmlEncode(u.RoleName)} · {System.Net.WebUtility.HtmlEncode(u.Email)}</div>
                  </button>
                </form>
                """);
        }

        sb.Append("""
            <div class="warn">⚠️ Ferramenta apenas de desenvolvimento — não existe em produção.</div>
            </div></body></html>
            """);

        return sb.ToString();
    }
}
