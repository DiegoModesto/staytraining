using Application.Abstractions.Messaging;
using Domain.Exercises;

namespace Application.Exercises.AddMedia;

/// <summary>
/// Persists a media record for an existing exercise. For stored media (GIF/video/muscle image)
/// the bytes are uploaded to object storage by the endpoint first, then <see cref="StorageKey"/>
/// is passed here. For YouTube, only <see cref="Url"/> is set.
/// </summary>
public sealed record AddExerciseMediaCommand(
    Guid ExerciseId,
    ExerciseMediaKind Kind,
    string? StorageKey,
    string? Url,
    string? ContentType,
    long? SizeBytes)
    : ICommand<Guid>;
