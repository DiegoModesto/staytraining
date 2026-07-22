namespace Infra.Notifications;

/// <summary>Bound from the <c>Fcm</c> configuration section.</summary>
public sealed class FcmOptions
{
    /// <summary>FCM legacy server key. When empty, push sending is skipped (logged only).</summary>
    public string ServerKey { get; set; } = string.Empty;

    public string Endpoint { get; set; } = "https://fcm.googleapis.com/fcm/send";
}
