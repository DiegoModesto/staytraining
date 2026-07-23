using Application.Abstractions.Messaging;
using Domain.Profiles;

namespace Application.Students.Ficha;

/// <summary>Admin edit of a student's ficha personal fields (audited).</summary>
public sealed record UpdateStudentFichaCommand(
    Guid StudentProfileId,
    string FullName,
    string? Email,
    string? Phone,
    string? EmergencyPhone,
    BloodType BloodType,
    int? HeightCm,
    decimal? WeightKg,
    string? Goals)
    : ICommand;

/// <summary>Admin adds a health apport to a student's ficha (audited).</summary>
public sealed record AddStudentApportmentCommand(
    Guid StudentProfileId, Guid BodyPartId, Guid ProblemTypeId, string? Observation)
    : ICommand<Guid>;

/// <summary>Admin removes a health apport from a student's ficha (audited).</summary>
public sealed record RemoveStudentApportmentCommand(Guid StudentProfileId, Guid ApportmentId) : ICommand;
