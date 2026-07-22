using Application.Abstractions.Messaging;
using Domain.Students;

namespace Application.Students.AddHealthObservation;

/// <summary>Adds an entry to a student's observation sheet (health issue or private professor note).</summary>
public sealed record AddHealthObservationCommand(
    Guid StudentProfileId,
    HealthObservationKind Kind,
    string Title,
    string? Detail)
    : ICommand<Guid>;
