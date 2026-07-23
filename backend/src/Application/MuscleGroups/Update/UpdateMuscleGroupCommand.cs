using Application.Abstractions.Messaging;

namespace Application.MuscleGroups.Update;

public sealed record UpdateMuscleGroupCommand(Guid Id, string Name, string BodyRegion) : ICommand;
