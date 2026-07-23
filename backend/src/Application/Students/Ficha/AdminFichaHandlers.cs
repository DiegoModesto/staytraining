using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Application.Students.Apportments;
using Domain.Students;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Students.Ficha;

public sealed class UpdateStudentFichaCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<UpdateStudentFichaCommand>
{
    public async Task<Result> Handle(UpdateStudentFichaCommand command, CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        StudentProfile? profile = await dbContext.StudentProfiles
            .FirstOrDefaultAsync(s => s.Id == command.StudentProfileId && !s.IsDeleted
                && (tenantId == null || s.TenantId == tenantId), cancellationToken);
        if (profile is null)
        {
            return Result.Failure(StudentErrors.NotFound(command.StudentProfileId));
        }

        profile.FullName = command.FullName.Trim();
        profile.Email = command.Email?.Trim();
        profile.Phone = command.Phone?.Trim();
        profile.EmergencyPhone = command.EmergencyPhone?.Trim();
        profile.BloodType = command.BloodType;
        profile.HeightCm = command.HeightCm;
        profile.WeightKg = command.WeightKg;
        profile.Goals = command.Goals?.Trim();

        AdminEditLog.Record(dbContext, userContext, profile.Id, "FichaUpdated", "Dados pessoais da ficha atualizados.");

        await dbContext.SaveChangesAsync(cancellationToken);
        return Result.Success();
    }
}

public sealed class AddStudentApportmentCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<AddStudentApportmentCommand, Guid>
{
    public async Task<Result<Guid>> Handle(AddStudentApportmentCommand command, CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        StudentProfile? profile = await dbContext.StudentProfiles
            .FirstOrDefaultAsync(s => s.Id == command.StudentProfileId && !s.IsDeleted
                && (tenantId == null || s.TenantId == tenantId), cancellationToken);
        if (profile is null)
        {
            return Result.Failure<Guid>(StudentErrors.NotFound(command.StudentProfileId));
        }

        Result<HealthApportment> apport = await ApportmentFactory.CreateAsync(
            dbContext, profile.Id, command.BodyPartId, command.ProblemTypeId, command.Observation, cancellationToken);
        if (apport.IsFailure)
        {
            return Result.Failure<Guid>(apport.Error);
        }

        dbContext.HealthApportments.Add(apport.Value);
        AdminEditLog.Record(dbContext, userContext, profile.Id, "ApportmentAdded",
            $"Apontamento adicionado: {apport.Value.BodyPartName} / {apport.Value.ProblemTypeName}.");

        await dbContext.SaveChangesAsync(cancellationToken);
        return apport.Value.Id;
    }
}

public sealed class RemoveStudentApportmentCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<RemoveStudentApportmentCommand>
{
    public async Task<Result> Handle(RemoveStudentApportmentCommand command, CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        StudentProfile? profile = await dbContext.StudentProfiles
            .FirstOrDefaultAsync(s => s.Id == command.StudentProfileId && !s.IsDeleted
                && (tenantId == null || s.TenantId == tenantId), cancellationToken);
        if (profile is null)
        {
            return Result.Failure(StudentErrors.NotFound(command.StudentProfileId));
        }

        HealthApportment? apport = await dbContext.HealthApportments
            .FirstOrDefaultAsync(a => a.Id == command.ApportmentId && a.StudentProfileId == profile.Id, cancellationToken);
        if (apport is null)
        {
            return Result.Failure(StudentErrors.NotFound(command.ApportmentId));
        }

        dbContext.HealthApportments.Remove(apport);
        AdminEditLog.Record(dbContext, userContext, profile.Id, "ApportmentRemoved",
            $"Apontamento removido: {apport.BodyPartName} / {apport.ProblemTypeName}.");

        await dbContext.SaveChangesAsync(cancellationToken);
        return Result.Success();
    }
}

internal static class AdminEditLog
{
    public static void Record(
        IApplicationDbContext dbContext, IUserContext userContext, Guid studentProfileId, string action, string detail)
    {
        dbContext.StudentEditLogs.Add(new StudentEditLog
        {
            Id = Guid.NewGuid(),
            StudentProfileId = studentProfileId,
            EditorUserId = userContext.UserId,
            EditorName = userContext.Name ?? "Administrador",
            Action = action,
            Detail = detail,
            CreatedAt = DateTimeOffset.UtcNow,
        });
    }
}
