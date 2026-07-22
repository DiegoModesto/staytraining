using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Students;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Students.GetById;

public sealed class GetStudentByIdQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<GetStudentByIdQuery, StudentDetailResponse>
{
    public async Task<Result<StudentDetailResponse>> Handle(
        GetStudentByIdQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        StudentDetailResponse? response = await dbContext.StudentProfiles
            .Where(s => s.Id == query.Id && !s.IsDeleted && (tenantId == null || s.TenantId == tenantId))
            .Select(s => new StudentDetailResponse(
                s.Id,
                s.UserId,
                s.FullName,
                s.Email,
                s.BirthDate,
                s.Goals,
                s.HealthObservations
                    .OrderByDescending(o => o.CreatedAt)
                    .Select(o => new HealthObservationResponse(o.Id, o.Kind, o.Title, o.Detail, o.CreatedAt))
                    .ToList()))
            .FirstOrDefaultAsync(cancellationToken);

        return response is null
            ? Result.Failure<StudentDetailResponse>(StudentErrors.NotFound(query.Id))
            : response;
    }
}
