using Domain.Exercises;

namespace Application.Exercises;

/// <summary>Media descriptor accepted when creating/updating an exercise.</summary>
public sealed record ExerciseMediaInput(
    ExerciseMediaKind Kind,
    string? StorageKey,
    string? Url,
    string? ContentType,
    long? SizeBytes);
