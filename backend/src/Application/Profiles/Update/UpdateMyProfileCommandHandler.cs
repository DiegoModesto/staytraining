using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Profiles;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Profiles.Update;

public sealed class UpdateMyProfileCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<UpdateMyProfileCommand>
{
    public async Task<Result> Handle(
        UpdateMyProfileCommand command,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to update the profile.");
        Guid userId = userContext.UserId;

        var student = await dbContext.StudentProfiles
            .FirstOrDefaultAsync(s => s.TenantId == tenantId && s.UserId == userId && !s.IsDeleted, cancellationToken);

        if (student is not null)
        {
            student.FullName = command.FullName.Trim();
            student.Email = command.Email.Trim();
            student.Phone = command.Phone?.Trim();
            student.EmergencyPhone = command.EmergencyPhone?.Trim();
            student.BloodType = command.BloodType;
            student.HeightCm = command.HeightCm;
            student.WeightKg = command.WeightKg;
            await dbContext.SaveChangesAsync(cancellationToken);
            return Result.Success();
        }

        var profile = await dbContext.UserProfiles
            .FirstOrDefaultAsync(p => p.TenantId == tenantId && p.UserId == userId && !p.IsDeleted, cancellationToken);

        if (profile is null)
        {
            profile = new UserProfile
            {
                Id = Guid.NewGuid(),
                TenantId = tenantId,
                UserId = userId,
                CreatedAt = DateTimeOffset.UtcNow,
            };
            dbContext.UserProfiles.Add(profile);
        }

        profile.FullName = command.FullName.Trim();
        profile.Email = command.Email.Trim();
        profile.Phone = command.Phone?.Trim();
        profile.BloodType = command.BloodType;
        profile.HeightCm = command.HeightCm;
        profile.WeightKg = command.WeightKg;

        await dbContext.SaveChangesAsync(cancellationToken);
        return Result.Success();
    }
}
