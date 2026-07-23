using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Application.Abstractions.Storage;
using Domain.Students;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Students.GetById;

public sealed class GetStudentByIdQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext,
    IFileStorage fileStorage)
    : IQueryHandler<GetStudentByIdQuery, StudentDetailResponse>
{
    public async Task<Result<StudentDetailResponse>> Handle(
        GetStudentByIdQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        var data = await dbContext.StudentProfiles
            .Where(s => s.Id == query.Id && !s.IsDeleted && (tenantId == null || s.TenantId == tenantId))
            .Select(s => new
            {
                s.Id,
                s.UserId,
                s.FullName,
                s.Email,
                s.BirthDate,
                s.Goals,
                s.Phone,
                s.EmergencyPhone,
                s.BloodType,
                s.HeightCm,
                s.WeightKg,
                s.PhotoKey,
                Apportments = s.HealthApportments
                    .OrderByDescending(a => a.CreatedAt)
                    .Select(a => new HealthApportmentResponse(
                        a.Id, a.BodyPartId, a.BodyPartName, a.ProblemTypeId, a.ProblemTypeName, a.Observation, a.CreatedAt))
                    .ToList(),
            })
            .FirstOrDefaultAsync(cancellationToken);

        if (data is null)
        {
            return Result.Failure<StudentDetailResponse>(StudentErrors.NotFound(query.Id));
        }

        string? photoUrl = string.IsNullOrEmpty(data.PhotoKey)
            ? null
            : await fileStorage.GetPresignedUrlAsync(data.PhotoKey, TimeSpan.FromHours(1), cancellationToken);

        return new StudentDetailResponse(
            data.Id, data.UserId, data.FullName, data.Email, data.BirthDate, data.Goals,
            data.Phone, data.EmergencyPhone, data.BloodType, data.HeightCm, data.WeightKg,
            photoUrl, data.Apportments);
    }
}
