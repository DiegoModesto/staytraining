using Application.Abstractions.Messaging;

namespace Application.MuscleGroups.Create;

public sealed record CreateMuscleGroupCommand(string Name, string BodyRegion) : ICommand<Guid>;
