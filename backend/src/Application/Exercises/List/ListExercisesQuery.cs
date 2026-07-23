using Application.Abstractions.Messaging;

namespace Application.Exercises.List;

/// <summary>Lists exercises for the current tenant, optionally filtered by modality.</summary>
public sealed record ListExercisesQuery(Guid? ModalityId)
    : IQuery<IReadOnlyCollection<ExerciseListItemResponse>>;

public sealed record ExerciseListItemResponse(
    Guid Id,
    string Name,
    Guid ModalityId,
    string ModalityName,
    Guid PrimaryMuscleGroupId,
    bool IsAerobic);
