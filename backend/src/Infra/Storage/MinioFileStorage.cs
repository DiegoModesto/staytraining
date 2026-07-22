using Application.Abstractions.Storage;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Minio;
using Minio.DataModel.Args;

namespace Infra.Storage;

/// <summary>
/// <see cref="IFileStorage"/> backed by MinIO (S3-compatible). Lazily ensures the target bucket
/// exists on first write.
/// </summary>
internal sealed class MinioFileStorage(
    IMinioClient client,
    IOptions<StorageOptions> options,
    ILogger<MinioFileStorage> logger)
    : IFileStorage
{
    private readonly StorageOptions _options = options.Value;
    private int _bucketEnsured;

    public async Task<string> UploadAsync(
        string key,
        Stream content,
        string contentType,
        long size,
        CancellationToken cancellationToken = default)
    {
        await EnsureBucketAsync(cancellationToken).ConfigureAwait(false);

        var args = new PutObjectArgs()
            .WithBucket(_options.Bucket)
            .WithObject(key)
            .WithStreamData(content)
            .WithObjectSize(size)
            .WithContentType(contentType);

        await client.PutObjectAsync(args, cancellationToken).ConfigureAwait(false);

        logger.LogInformation("Uploaded object {Key} ({Size} bytes) to bucket {Bucket}.",
            key, size, _options.Bucket);

        return key;
    }

    public async Task<string> GetPresignedUrlAsync(
        string key,
        TimeSpan expiry,
        CancellationToken cancellationToken = default)
    {
        var args = new PresignedGetObjectArgs()
            .WithBucket(_options.Bucket)
            .WithObject(key)
            .WithExpiry((int)expiry.TotalSeconds);

        return await client.PresignedGetObjectAsync(args).ConfigureAwait(false);
    }

    public async Task DeleteAsync(string key, CancellationToken cancellationToken = default)
    {
        var args = new RemoveObjectArgs()
            .WithBucket(_options.Bucket)
            .WithObject(key);

        await client.RemoveObjectAsync(args, cancellationToken).ConfigureAwait(false);
    }

    private async Task EnsureBucketAsync(CancellationToken cancellationToken)
    {
        if (Interlocked.CompareExchange(ref _bucketEnsured, 1, 0) == 1)
        {
            return;
        }

        bool exists = await client
            .BucketExistsAsync(new BucketExistsArgs().WithBucket(_options.Bucket), cancellationToken)
            .ConfigureAwait(false);

        if (!exists)
        {
            await client
                .MakeBucketAsync(new MakeBucketArgs().WithBucket(_options.Bucket), cancellationToken)
                .ConfigureAwait(false);

            logger.LogInformation("Created storage bucket {Bucket}.", _options.Bucket);
        }
    }
}
