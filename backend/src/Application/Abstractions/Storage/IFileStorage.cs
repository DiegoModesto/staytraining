namespace Application.Abstractions.Storage;

/// <summary>
/// Object storage abstraction for media assets (GIFs, uploaded videos, muscle images).
/// Implemented over MinIO in the infrastructure layer.
/// </summary>
public interface IFileStorage
{
    /// <summary>Uploads an object and returns its storage key.</summary>
    Task<string> UploadAsync(
        string key,
        Stream content,
        string contentType,
        long size,
        CancellationToken cancellationToken = default);

    /// <summary>Returns a time-limited, publicly reachable URL for reading the object.</summary>
    Task<string> GetPresignedUrlAsync(
        string key,
        TimeSpan expiry,
        CancellationToken cancellationToken = default);

    Task DeleteAsync(string key, CancellationToken cancellationToken = default);
}
