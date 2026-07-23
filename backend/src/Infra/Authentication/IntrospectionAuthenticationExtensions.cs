using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Http;
using OpenIddict.Abstractions;
using OpenIddict.Validation.AspNetCore;

namespace Infra.Authentication;

public static class IntrospectionAuthenticationExtensions
{
    // Name OpenIddict.Validation.SystemNetHttp uses to register its IHttpClientFactory client.
    private const string OpenIddictValidationHttpClientName = "OpenIddict.Validation.SystemNetHttp";

    public static IServiceCollection AddIntrospectionAuthentication(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        IConfigurationSection section = configuration.GetSection("Auth");
        string issuer = section["Authority"]
            ?? throw new InvalidOperationException("Auth:Authority is required.");
        // Used to build a static server configuration (below) so we never fetch the discovery
        // document. This decouples the issuer (what tokens carry, e.g. the public Auth.API URL)
        // from the network address used to reach introspection (e.g. an in-cluster URL) — otherwise
        // the issuer advertised in discovery must match the address we fetch it from, which breaks
        // whenever the two differ (classic docker: app hits localhost:5100, services hit auth.api:8080).
        string introspectionEndpoint = section["IntrospectionEndpoint"]
            ?? throw new InvalidOperationException("Auth:IntrospectionEndpoint is required.");
        string clientId = section["IntrospectionClientId"]
            ?? throw new InvalidOperationException("Auth:IntrospectionClientId is required.");
        string clientSecret = section["IntrospectionClientSecret"]
            ?? throw new InvalidOperationException("Auth:IntrospectionClientSecret is required.");

        // Optional Redis-backed introspection cache. When Redis is configured we attach a
        // DelegatingHandler to the OpenIddict introspection HttpClient that caches responses
        // by token hash. When Redis is absent (e.g. in-process tests that wire their own
        // mocks), the handler is skipped — OpenIddict still works, just without caching.
        string? redisConn = configuration["Redis:ConnectionString"];
        if (!string.IsNullOrWhiteSpace(redisConn))
        {
            services.AddStackExchangeRedisCache(o => o.Configuration = redisConn);
            services.Configure<IntrospectionCacheOptions>(
                configuration.GetSection(IntrospectionCacheOptions.SectionName));
            services.AddTransient<IntrospectionCachingHandler>();

            services.PostConfigure<HttpClientFactoryOptions>(
                OpenIddictValidationHttpClientName,
                options =>
                {
                    options.HttpMessageHandlerBuilderActions.Add(builder =>
                    {
                        IntrospectionCachingHandler handler = builder.Services
                            .GetRequiredService<IntrospectionCachingHandler>();
                        builder.AdditionalHandlers.Add(handler);
                    });
                });
        }

        services.AddOpenIddict()
            .AddValidation(o =>
            {
                o.SetIssuer(new Uri(issuer));
                // Static configuration => no discovery round-trip, so the token issuer and the
                // introspection network address can legitimately differ (see note above).
                o.SetConfiguration(new OpenIddictConfiguration
                {
                    Issuer = new Uri(issuer),
                    IntrospectionEndpoint = new Uri(introspectionEndpoint),
                });
                o.AddAudiences("api:web");
                o.UseIntrospection()
                    .SetClientId(clientId)
                    .SetClientSecret(clientSecret);
                o.UseSystemNetHttp()
                    .ConfigureHttpClient(c => c.Timeout = TimeSpan.FromSeconds(5));
                o.UseAspNetCore();
            });

        services.AddAuthentication(OpenIddictValidationAspNetCoreDefaults.AuthenticationScheme);

        return services;
    }
}
