namespace Domain.Exercises;

/// <summary>
/// A media asset attached to an <see cref="Exercise"/>: a GIF/video/muscle image stored in MinIO
/// (referenced by <see cref="StorageKey"/>) or an external YouTube link (referenced by <see cref="Url"/>).
/// </summary>
public sealed class ExerciseMedia
{
    public Guid Id { get; set; }
    public Guid ExerciseId { get; set; }
    public ExerciseMediaKind Kind { get; set; }

    /// <summary>Object key in MinIO for stored media (Gif/UploadedVideo/MuscleImage). Null for YouTube.</summary>
    public string? StorageKey { get; set; }

    /// <summary>External URL (YouTube). Null for stored media.</summary>
    public string? Url { get; set; }

    public string? ContentType { get; set; }
    public long? SizeBytes { get; set; }
}
