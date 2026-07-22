using Auth.API;
using Auth.API.Authentication;
using Auth.API.Endpoints.DevLogin;
using Auth.API.Extensions;
using Auth.API.Telemetry;
using Auth.Application;
using Auth.Infra;
using Auth.Infra.Database;
using Auth.Infra.OpenIddict;
using Infra.Observability;
using Microsoft.EntityFrameworkCore;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

builder.Host.UseSerilog((ctx, sp, cfg) =>
    cfg.ReadFrom.Configuration(ctx.Configuration).ReadFrom.Services(sp));

builder.Services.AddOpenTelemetryObservability(
    builder.Configuration,
    serviceName: "Auth.API",
    includeAspNetCore: true,
    additionalActivitySources: AuthActivitySource.Name);

builder.Services.AddAuthApplication();
builder.Services.AddAuthInfrastructure(builder.Configuration);
builder.Services.AddAuthOpenIddict(builder.Configuration);
builder.Services.AddAuthApiPresentation(builder.Configuration, builder.Environment);

// Stand-alone dev: seed a local tenant + mock users so the "/dev-login" flow issues real tokens
// without Microsoft Entra. Only when Entra is not configured (otherwise the real flow is in play).
if (builder.Environment.IsDevelopment() && !EntraAuthenticationExtensions.IsConfigured(builder.Configuration))
{
    builder.Services.AddAuthDevIdentitySeeding();
}

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    using var scope = app.Services.CreateScope();
    var db = scope.ServiceProvider.GetRequiredService<AuthDbContext>();
    await db.Database.MigrateAsync();
}

app.UseSerilogRequestLogging();
app.UseAuthentication();
app.UseAuthorization();

app.MapEndpoints();

// Development-only local login page (see DevLoginEndpoints), mapped here — never via IEndpoint
// auto-registration — so it cannot exist in a production build. Gated identically to the dev scheme.
if (app.Environment.IsDevelopment() && !EntraAuthenticationExtensions.IsConfigured(app.Configuration))
{
    DevLoginEndpoints.Map(app);
}

app.MapGet("/health/live", () => Results.Ok(new { status = "live" }));
app.MapHealthChecks("/health/ready", new()
{
    Predicate = h => h.Tags.Contains("ready")
});

await app.RunAsync();

namespace Auth.API
{
    public partial class Program;
}
