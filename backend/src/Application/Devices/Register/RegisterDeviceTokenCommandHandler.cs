using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Devices;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Devices.Register;

public sealed class RegisterDeviceTokenCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<RegisterDeviceTokenCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        RegisterDeviceTokenCommand command,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to register a device token.");

        DateTimeOffset now = DateTimeOffset.UtcNow;

        DeviceToken? existing = await dbContext.DeviceTokens
            .FirstOrDefaultAsync(d => d.Token == command.Token, cancellationToken);

        if (existing is not null)
        {
            existing.UserId = userContext.UserId;
            existing.TenantId = tenantId;
            existing.Platform = command.Platform;
            existing.LastSeenAt = now;
            existing.IsDeleted = false;
            existing.DeletedAt = null;

            await dbContext.SaveChangesAsync(cancellationToken);
            return existing.Id;
        }

        var token = new DeviceToken
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            UserId = userContext.UserId,
            Token = command.Token,
            Platform = command.Platform,
            LastSeenAt = now,
            CreatedAt = now,
        };

        dbContext.DeviceTokens.Add(token);
        await dbContext.SaveChangesAsync(cancellationToken);

        return token.Id;
    }
}
