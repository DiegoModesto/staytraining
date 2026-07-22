using SharedKernel;

namespace Domain.Devices;

public enum DevicePlatform
{
    Android = 0,
    Ios = 1,
}

/// <summary>An FCM registration token for a user's device, used to deliver push notifications.</summary>
public sealed class DeviceToken : Entity
{
    public Guid Id { get; set; }
    public Guid TenantId { get; set; }
    public Guid UserId { get; set; }

    public string Token { get; set; } = string.Empty;
    public DevicePlatform Platform { get; set; }

    public DateTimeOffset LastSeenAt { get; set; }
}
