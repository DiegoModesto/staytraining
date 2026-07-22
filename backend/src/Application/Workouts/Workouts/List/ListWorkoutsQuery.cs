using Application.Abstractions.Messaging;

namespace Application.Workouts.Workouts.List;

/// <summary>Lists workouts for a student (or all in the tenant when <paramref name="OwnerStudentId"/> is null).</summary>
public sealed record ListWorkoutsQuery(Guid? OwnerStudentId)
    : IQuery<IReadOnlyCollection<WorkoutListItemResponse>>;
