namespace Application.Abstractions.Notifications;

/// <summary>Sends push notifications to user devices (implemented over FCM in the infra layer).</summary>
public interface IPushSender
{
    /// <summary>Sends a notification to every registered device of the given user.</summary>
    Task SendToUserAsync(
        Guid userId,
        string title,
        string body,
        IReadOnlyDictionary<string, string>? data = null,
        CancellationToken cancellationToken = default);
}
