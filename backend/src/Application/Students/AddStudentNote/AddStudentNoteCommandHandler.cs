using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Students;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Students.AddStudentNote;

public sealed class AddStudentNoteCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<AddStudentNoteCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        AddStudentNoteCommand command,
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

        var note = new StudentNote
        {
            Id = Guid.NewGuid(),
            StudentProfileId = command.StudentProfileId,
            AuthorUserId = userContext.UserId,
            AuthorName = string.IsNullOrWhiteSpace(userContext.Name) ? "Professor" : userContext.Name,
            Content = command.Content,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        dbContext.StudentNotes.Add(note);
        await dbContext.SaveChangesAsync(cancellationToken);

        return note.Id;
    }
}
