using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Application.Abstractions.Notifications;
using Application.Abstractions.Storage;
using Infra.Authentication;
using Infra.Database;
using Infra.Messaging;
using Infra.Notifications;
using Infra.Storage;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Minio;

namespace Infra;

public static class DependencyInjection
{
    public const string DatabaseConnectionName = "Database";

    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
        => services
            .AddDatabase(configuration)
            .AddAuthenticationInternal(configuration)
            .AddAuthorizationInternal();

    public static IServiceCollection AddNotifications(this IServiceCollection services, IConfiguration configuration)
    {
        services.Configure<FcmOptions>(configuration.GetSection("Fcm"));
        services.AddHttpClient<IPushSender, FcmPushSender>();
        return services;
    }

    /// <summary>Registers the idempotent reference-data / default-template seeder (runs on startup).</summary>
    public static IServiceCollection AddDataSeeding(this IServiceCollection services)
    {
        services.AddHostedService<SeedDataHostedService>();
        return services;
    }

    public static IServiceCollection AddStorage(this IServiceCollection services, IConfiguration configuration)
    {
        IConfigurationSection section = configuration.GetSection("Storage");
        services.Configure<StorageOptions>(section);

        var options = section.Get<StorageOptions>() ?? new StorageOptions();

        if (string.IsNullOrWhiteSpace(options.Endpoint)
            || string.IsNullOrWhiteSpace(options.AccessKey)
            || string.IsNullOrWhiteSpace(options.SecretKey))
        {
            throw new InvalidOperationException(
                "Storage:Endpoint, Storage:AccessKey and Storage:SecretKey must be configured. "
                + "Set them via appsettings or STORAGE_ENDPOINT / STORAGE_ACCESS_KEY / STORAGE_SECRET_KEY.");
        }

        services.AddSingleton<IMinioClient>(_ => new MinioClient()
            .WithEndpoint(options.Endpoint)
            .WithCredentials(options.AccessKey, options.SecretKey)
            .WithSSL(options.UseSsl)
            .Build());

        services.AddSingleton<IFileStorage, MinioFileStorage>();

        return services;
    }

    public static IServiceCollection AddDatabase(this IServiceCollection services, IConfiguration configuration)
    {
        string? connectionString = configuration.GetConnectionString(DatabaseConnectionName);

        if (string.IsNullOrWhiteSpace(connectionString))
        {
            throw new InvalidOperationException(
                $"Connection string '{DatabaseConnectionName}' must be configured.");
        }

        services
            .AddDbContext<ApplicationDbContext>(options =>
                options.UseNpgsql(connectionString, npgsqlOptions =>
                    npgsqlOptions.MigrationsHistoryTable(HistoryRepository.DefaultTableName, Schemas.Default))
                .UseSnakeCaseNamingConvention());

        services.AddScoped<IApplicationDbContext>(sp => sp.GetRequiredService<ApplicationDbContext>());

        return services;
    }

    private static IServiceCollection AddAuthenticationInternal(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddIntrospectionAuthentication(configuration);

        services.AddHttpContextAccessor();

        services.AddScoped<IUserContext, UserContext>();
        services.AddSingleton<IPasswordHasher, PasswordHasher>();
        services.AddScoped<ITokenProvider, TokenProvider>();

        return services;
    }

    private static IServiceCollection AddAuthorizationInternal(this IServiceCollection services)
    {
        services.AddAuthorization();
        return services;
    }

    public static IServiceCollection AddInfrastructureMessaging(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        IConfigurationSection section = configuration.GetSection("RabbitMq");

        if (!section.Exists())
        {
            throw new InvalidOperationException(
                "RabbitMq configuration section is missing. "
                + "Provide RabbitMq:Host, User, Password, ExchangeName via appsettings or RABBITMQ_* environment variables.");
        }

        var options = section.Get<RabbitMqOptions>() ?? new RabbitMqOptions();

        if (string.IsNullOrWhiteSpace(options.Host)
            || string.IsNullOrWhiteSpace(options.User)
            || string.IsNullOrWhiteSpace(options.Password)
            || string.IsNullOrWhiteSpace(options.ExchangeName))
        {
            throw new InvalidOperationException(
                "RabbitMq:Host, RabbitMq:User, RabbitMq:Password and RabbitMq:ExchangeName must be configured. "
                + "Set them via appsettings or RABBITMQ_HOST / RABBITMQ_USER / RABBITMQ_PASSWORD / RABBITMQ_EXCHANGE.");
        }

        services.Configure<RabbitMqOptions>(section);
        services.AddSingleton<RabbitMqConnectionFactory>();
        services.AddSingleton<IMessagePublisher, RabbitMqMessagePublisher>();

        return services;
    }
}
