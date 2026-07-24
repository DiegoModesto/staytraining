using Application.Abstractions.Messaging;

namespace Application.Execution.Schedule;

/// <summary>Student justifies not doing a scheduled workout (holiday, gym closed, illness…).</summary>
public sealed record JustifySkipScheduleCommand(Guid ScheduleId, string Reason, string? Note) : ICommand;
