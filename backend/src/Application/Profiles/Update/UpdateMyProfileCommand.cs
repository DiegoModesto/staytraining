using Application.Abstractions.Messaging;
using Domain.Profiles;

namespace Application.Profiles.Update;

public sealed record UpdateMyProfileCommand(
    string FullName,
    string Email,
    string? Phone,
    string? EmergencyPhone,
    BloodType BloodType,
    int? HeightCm,
    decimal? WeightKg)
    : ICommand;
