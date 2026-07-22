using Application.Abstractions.Messaging;
using Domain.Devices;

namespace Application.Devices.Register;

public sealed record RegisterDeviceTokenCommand(string Token, DevicePlatform Platform) : ICommand<Guid>;
