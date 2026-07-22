using Application.Abstractions.Messaging;

namespace Application.Workouts.Workouts.ReorderItems;

/// <summary>Reorders the workout's items to match the given sequence of item ids.</summary>
public sealed record ReorderWorkoutItemsCommand(Guid WorkoutId, IReadOnlyList<Guid> OrderedItemIds) : ICommand;
