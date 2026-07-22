using Application.Abstractions.Messaging;

namespace Application.MuscleGroups.List;

public sealed record ListMuscleGroupsQuery : IQuery<IReadOnlyCollection<MuscleGroupResponse>>;

public sealed record MuscleGroupResponse(Guid Id, string Name, string BodyRegion);
