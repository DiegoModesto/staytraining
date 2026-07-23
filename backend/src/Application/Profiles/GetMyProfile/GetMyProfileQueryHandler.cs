using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Application.Abstractions.Storage;
using Domain.Profiles;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Profiles.GetMyProfile;

public sealed class GetMyProfileQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext,
    IFileStorage fileStorage)
    : IQueryHandler<GetMyProfileQuery, ProfileResponse>
{
    private static readonly TimeSpan PhotoUrlTtl = TimeSpan.FromHours(1);

    public async Task<Result<ProfileResponse>> Handle(
        GetMyProfileQuery query,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to read the profile.");
        Guid userId = userContext.UserId;

        // A student edits their StudentProfile (ficha); everyone else gets a UserProfile.
        var student = await dbContext.StudentProfiles
            .Where(s => s.TenantId == tenantId && s.UserId == userId && !s.IsDeleted)
            .Select(s => new
            {
                s.FullName,
                s.Email,
                s.Phone,
                s.EmergencyPhone,
                s.BloodType,
                s.HeightCm,
                s.WeightKg,
                s.PhotoKey,
                Apportments = s.HealthApportments
                    .OrderByDescending(a => a.CreatedAt)
                    .Select(a => new ProfileApportmentResponse(a.Id, a.BodyPartName, a.ProblemTypeName, a.Observation))
                    .ToList(),
            })
            .FirstOrDefaultAsync(cancellationToken);

        if (student is not null)
        {
            return new ProfileResponse(
                IsStudent: true,
                student.FullName,
                student.Email ?? string.Empty,
                student.Phone,
                student.EmergencyPhone,
                student.BloodType,
                student.HeightCm,
                student.WeightKg,
                await PhotoUrlAsync(student.PhotoKey, cancellationToken),
                student.Apportments);
        }

        var profile = await dbContext.UserProfiles
            .Where(p => p.TenantId == tenantId && p.UserId == userId && !p.IsDeleted)
            .FirstOrDefaultAsync(cancellationToken);

        // No profile row yet — return a shell seeded with the token's display name so the form opens.
        return new ProfileResponse(
            IsStudent: false,
            profile?.FullName ?? userContext.Name ?? string.Empty,
            profile?.Email ?? string.Empty,
            profile?.Phone,
            EmergencyPhone: null,
            profile?.BloodType ?? BloodType.Unknown,
            profile?.HeightCm,
            profile?.WeightKg,
            await PhotoUrlAsync(profile?.PhotoKey, cancellationToken),
            []);
    }

    private async Task<string?> PhotoUrlAsync(string? key, CancellationToken ct) =>
        string.IsNullOrEmpty(key) ? null : await fileStorage.GetPresignedUrlAsync(key, PhotoUrlTtl, ct);
}
