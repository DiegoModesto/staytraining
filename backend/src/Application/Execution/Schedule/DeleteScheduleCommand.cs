using Application.Abstractions.Messaging;

namespace Application.Execution.Schedule;

/// <summary>Removes a scheduled workout (soft-delete). Owner-only unless a manager (professor).</summary>
public sealed record DeleteScheduleCommand(Guid ScheduleId) : ICommand;
