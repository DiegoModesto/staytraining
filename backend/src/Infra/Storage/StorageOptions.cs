namespace Infra.Storage;

/// <summary>Bound from the <c>Storage</c> configuration section (MinIO / S3-compatible).</summary>
public sealed class StorageOptions
{
    /// <summary>MinIO endpoint the API talks to, e.g. <c>localhost:9000</c> (no scheme).</summary>
    public string Endpoint { get; set; } = string.Empty;

    public string AccessKey { get; set; } = string.Empty;
    public string SecretKey { get; set; } = string.Empty;

    /// <summary>Bucket that holds exercise media.</summary>
    public string Bucket { get; set; } = "exercise-media";

    public bool UseSsl { get; set; }

    /// <summary>
    /// Optional public endpoint used when generating presigned URLs (e.g. the host reachable by
    /// mobile clients). Falls back to <see cref="Endpoint"/> when empty.
    /// </summary>
    public string? PublicEndpoint { get; set; }
}
