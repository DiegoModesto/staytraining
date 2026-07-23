using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.HealthCatalog;
using Domain.Students;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Students.Apportments;

public sealed class AddMyApportmentCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<AddMyApportmentCommand, Guid>
{
    public async Task<Result<Guid>> Handle(AddMyApportmentCommand command, CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId ?? throw new InvalidOperationException("TenantId is required.");
        Guid userId = userContext.UserId;

        StudentProfile? profile = await dbContext.StudentProfiles
            .FirstOrDefaultAsync(s => s.TenantId == tenantId && s.UserId == userId && !s.IsDeleted, cancellationToken);
        if (profile is null)
        {
            return Result.Failure<Guid>(StudentErrors.NotFound(userId));
        }

        Result<HealthApportment> apport = await ApportmentFactory.CreateAsync(
            dbContext, profile.Id, command.BodyPartId, command.ProblemTypeId, command.Observation, cancellationToken);
        if (apport.IsFailure)
        {
            return Result.Failure<Guid>(apport.Error);
        }

        dbContext.HealthApportments.Add(apport.Value);
        await dbContext.SaveChangesAsync(cancellationToken);
        return apport.Value.Id;
    }
}

public sealed class RemoveMyApportmentCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<RemoveMyApportmentCommand>
{
    public async Task<Result> Handle(RemoveMyApportmentCommand command, CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId ?? throw new InvalidOperationException("TenantId is required.");
        Guid userId = userContext.UserId;

        // Join through the profile so a user can only remove apports from their OWN ficha.
        HealthApportment? apport = await dbContext.HealthApportments
            .Where(a => a.Id == command.ApportmentId)
            .Where(a => dbContext.StudentProfiles.Any(s =>
                s.Id == a.StudentProfileId && s.TenantId == tenantId && s.UserId == userId))
            .FirstOrDefaultAsync(cancellationToken);
        if (apport is null)
        {
            return Result.Failure(StudentErrors.NotFound(command.ApportmentId));
        }

        dbContext.HealthApportments.Remove(apport);
        await dbContext.SaveChangesAsync(cancellationToken);
        return Result.Success();
    }
}

/// <summary>Builds a <see cref="HealthApportment"/> from catalog ids, validating and denormalizing names.</summary>
internal static class ApportmentFactory
{
    public static async Task<Result<HealthApportment>> CreateAsync(
        IApplicationDbContext dbContext,
        Guid studentProfileId,
        Guid bodyPartId,
        Guid problemTypeId,
        string? observation,
        CancellationToken cancellationToken)
    {
        BodyPart? bodyPart = await dbContext.BodyParts
            .FirstOrDefaultAsync(b => b.Id == bodyPartId, cancellationToken);
        if (bodyPart is null)
        {
            return Result.Failure<HealthApportment>(HealthCatalogErrors.BodyPartNotFound(bodyPartId));
        }

        ProblemType? problemType = await dbContext.ProblemTypes
            .FirstOrDefaultAsync(p => p.Id == problemTypeId && p.BodyPartId == bodyPartId, cancellationToken);
        if (problemType is null)
        {
            return Result.Failure<HealthApportment>(HealthCatalogErrors.ProblemTypeNotFound(problemTypeId));
        }

        return new HealthApportment
        {
            Id = Guid.NewGuid(),
            StudentProfileId = studentProfileId,
            BodyPartId = bodyPart.Id,
            BodyPartName = bodyPart.Name,
            ProblemTypeId = problemType.Id,
            ProblemTypeName = problemType.Name,
            Observation = string.IsNullOrWhiteSpace(observation) ? null : observation.Trim(),
            CreatedAt = DateTimeOffset.UtcNow,
        };
    }
}
