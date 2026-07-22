using Application;
using Asp.Versioning;
using Asp.Versioning.Builder;
using Infra;
using Infra.Database;
using Infra.Extensions;
using Infra.Observability;
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Serilog;
using Web.API;
using Web.API.Extensions;
using Web.API.Middleware;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Configuration.MapEnvironmentVariables();

builder.Host.UseSerilog((context, loggerConfig) =>
    loggerConfig.ReadFrom.Configuration(context.Configuration));

builder.Services
    .AddHealthChecks()
    .AddNpgSql(
        connectionString: builder.Configuration.GetConnectionString(Infra.DependencyInjection.DatabaseConnectionName)!,
        name: "database",
        timeout: TimeSpan.FromSeconds(5))
    .AddCheck(name: "api", check: () => HealthCheckResult.Healthy("API OK"));

builder.Services.AddSwaggerGenWithAuth();

builder.Services
    .AddApplication()
    .AddPresentation()
    .AddInfrastructure(builder.Configuration)
    .AddInfrastructureMessaging(builder.Configuration)
    .AddStorage(builder.Configuration)
    .AddNotifications(builder.Configuration)
    .AddDataSeeding()
    .AddApiCors(builder.Configuration)
    .AddApiRateLimiting()
    .AddOpenTelemetryObservability(builder.Configuration, serviceName: "Web.API", includeAspNetCore: true);

WebApplication app = builder.Build();

// Development convenience: apply pending migrations on startup so a fresh local database
// (and the SeedDataHostedService that runs right after) works without a manual `dotnet ef
// database update`. Production applies migrations out-of-band, never on app startup.
if (app.Environment.IsDevelopment())
{
    using IServiceScope scope = app.Services.CreateScope();
    ApplicationDbContext dbContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
    await dbContext.Database.MigrateAsync();
}

ApiVersionSet apiVersionSet = app.NewApiVersionSet()
    .HasApiVersion(new ApiVersion(1))
    .ReportApiVersions()
    .Build();

RouteGroupBuilder versionedGroup = app
    .MapGroup("api/v{version:apiVersion}")
    .WithApiVersionSet(apiVersionSet);

app.MapEndpoints(versionedGroup);

app.MapHealthChecks("/health", new HealthCheckOptions
{
    ResponseWriter = HealthCheckResponseWriter.WriteResponse
});
app.MapHealthChecks("/health/ready", new HealthCheckOptions
{
    Predicate = check => check.Name != "database",
    ResponseWriter = HealthCheckResponseWriter.WriteResponse
});
app.MapHealthChecks("/health/live", new HealthCheckOptions
{
    Predicate = _ => false,
    ResponseWriter = HealthCheckResponseWriter.WriteResponse
});

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.UseSwagger();
    app.UseSwaggerUI();
}
else
{
    app.UseHsts();
    app.UseHttpsRedirection();
}

app.UseMiddleware<SecurityHeadersMiddleware>();
app.UseCors(SecurityExtensions.DefaultCorsPolicy);
app.UseRateLimiter();

app.UseRequestContextLogging();
app.UseSerilogRequestLogging();

app.UseMiddleware<GlobalExceptionHandlingMiddleware>();

app.UseAuthentication();
app.UseMiddleware<TenantContextMiddleware>();
app.UseAuthorization();

await app.RunAsync();

namespace Web.API
{
    public partial class Program;
}
