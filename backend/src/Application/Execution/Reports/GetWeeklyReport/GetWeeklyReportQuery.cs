using Application.Abstractions.Messaging;

namespace Application.Execution.Reports.GetWeeklyReport;

/// <summary>Synthesized weekly report of executed exercises for a student.</summary>
public sealed record GetWeeklyReportQuery(DateOnly WeekStart, Guid? StudentId)
    : IQuery<WeeklyReportResponse>;
