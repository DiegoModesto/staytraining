using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Students;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Students.AddHealthObservation;

public sealed class AddHealthObservationCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<AddHealthObservationCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        AddHealthObservationCommand command,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        bool studentExists = await dbContext.StudentProfiles
            .AnyAsync(s => s.Id == command.StudentProfileId && !s.IsDeleted
                && (tenantId == null || s.TenantId == tenantId), cancellationToken);

        if (!studentExists)
        {
            return Result.Failure<Guid>(StudentErrors.NotFound(command.StudentProfileId));
        }

        var observation = new HealthObservation
        {
            Id = Guid.NewGuid(),
            StudentProfileId = command.StudentProfileId,
            Kind = command.Kind,
            Title = command.Title,
            Detail = command.Detail,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        dbContext.HealthObservations.Add(observation);
        await dbContext.SaveChangesAsync(cancellationToken);

        return observation.Id;
    }
}
