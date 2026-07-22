using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Students;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Students.Register;

public sealed class RegisterStudentCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<RegisterStudentCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        RegisterStudentCommand command,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to register a student.");

        bool exists = await dbContext.StudentProfiles
            .AnyAsync(s => s.TenantId == tenantId && s.UserId == command.UserId && !s.IsDeleted, cancellationToken);

        if (exists)
        {
            return Result.Failure<Guid>(StudentErrors.AlreadyRegistered);
        }

        var student = new StudentProfile
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            UserId = command.UserId,
            FullName = command.FullName,
            Email = command.Email,
            BirthDate = command.BirthDate,
            Goals = command.Goals,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        dbContext.StudentProfiles.Add(student);
        await dbContext.SaveChangesAsync(cancellationToken);

        return student.Id;
    }
}
