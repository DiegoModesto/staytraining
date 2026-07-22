namespace Domain.Exercises;

public enum ExerciseMediaKind
{
    /// <summary>Animated GIF stored in object storage (MinIO). Uses <see cref="ExerciseMedia.StorageKey"/>.</summary>
    Gif = 0,

    /// <summary>Uploaded video stored in object storage (MinIO). Uses <see cref="ExerciseMedia.StorageKey"/>.</summary>
    UploadedVideo = 1,

    /// <summary>External YouTube video. Uses <see cref="ExerciseMedia.Url"/>.</summary>
    YoutubeUrl = 2,

    /// <summary>Image highlighting the affected muscle. Uses <see cref="ExerciseMedia.StorageKey"/>.</summary>
    MuscleImage = 3,
}
