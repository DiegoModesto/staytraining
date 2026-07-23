using Application.Abstractions.Messaging;

namespace Application.MuscleGroups.Delete;

public sealed record DeleteMuscleGroupCommand(Guid Id) : ICommand;
