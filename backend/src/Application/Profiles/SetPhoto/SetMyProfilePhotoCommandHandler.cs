using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Profiles;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Profiles.SetPhoto;

public sealed class SetMyProfilePhotoCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<SetMyProfilePhotoCommand>
{
    public async Task<Result> Handle(
        SetMyProfilePhotoCommand command,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to set the profile photo.");
        Guid userId = userContext.UserId;

        var student = await dbContext.StudentProfiles
            .FirstOrDefaultAsync(s => s.TenantId == tenantId && s.UserId == userId && !s.IsDeleted, cancellationToken);
        if (student is not null)
        {
            student.PhotoKey = command.PhotoKey;
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
                FullName = userContext.Name ?? string.Empty,
                CreatedAt = DateTimeOffset.UtcNow,
            };
            dbContext.UserProfiles.Add(profile);
        }

        profile.PhotoKey = command.PhotoKey;
        await dbContext.SaveChangesAsync(cancellationToken);
        return Result.Success();
    }
}
