using System.Net.Http.Headers;
using System.Net.Http.Json;
using Application.Abstractions.Data;
using Application.Abstractions.Notifications;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace Infra.Notifications;

/// <summary>
/// <see cref="IPushSender"/> over Firebase Cloud Messaging (legacy HTTP API). Looks up the user's
/// registered device tokens and sends them a single multicast notification. If no server key is
/// configured, the send is skipped and logged (safe for local dev / tests).
/// </summary>
internal sealed class FcmPushSender(
    IApplicationDbContext dbContext,
    HttpClient httpClient,
    IOptions<FcmOptions> options,
    ILogger<FcmPushSender> logger)
    : IPushSender
{
    private readonly FcmOptions _options = options.Value;

    public async Task SendToUserAsync(
        Guid userId,
        string title,
        string body,
        IReadOnlyDictionary<string, string>? data = null,
        CancellationToken cancellationToken = default)
    {
        List<string> tokens = await dbContext.DeviceTokens
            .Where(d => d.UserId == userId && !d.IsDeleted)
            .Select(d => d.Token)
            .ToListAsync(cancellationToken);

        if (tokens.Count == 0)
        {
            logger.LogInformation("No device tokens for user {UserId}; skipping push.", userId);
            return;
        }

        if (string.IsNullOrWhiteSpace(_options.ServerKey))
        {
            logger.LogWarning(
                "Fcm:ServerKey not configured; would have pushed '{Title}' to {Count} device(s) of user {UserId}.",
                title, tokens.Count, userId);
            return;
        }

        var payload = new
        {
            registration_ids = tokens,
            notification = new { title, body },
            data = data ?? new Dictionary<string, string>(),
        };

        using var request = new HttpRequestMessage(HttpMethod.Post, _options.Endpoint)
        {
            Content = JsonContent.Create(payload),
        };
        request.Headers.TryAddWithoutValidation("Authorization", $"key={_options.ServerKey}");
        request.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

        using HttpResponseMessage response = await httpClient.SendAsync(request, cancellationToken);

        if (!response.IsSuccessStatusCode)
        {
            logger.LogError(
                "FCM push to user {UserId} failed with status {Status}.", userId, (int)response.StatusCode);
        }
        else
        {
            logger.LogInformation("Pushed '{Title}' to {Count} device(s) of user {UserId}.",
                title, tokens.Count, userId);
        }
    }
}
