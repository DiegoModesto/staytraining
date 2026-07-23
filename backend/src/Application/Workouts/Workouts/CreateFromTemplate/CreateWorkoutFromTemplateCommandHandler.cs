using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Workouts.Workouts.CreateFromTemplate;

public sealed class CreateWorkoutFromTemplateCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<CreateWorkoutFromTemplateCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        CreateWorkoutFromTemplateCommand command,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to copy a template.");

        WorkoutTemplate? template = await dbContext.WorkoutTemplates
            .Include(t => t.Items)
            .FirstOrDefaultAsync(
                t => t.Id == command.TemplateId && !t.IsDeleted && t.TenantId == tenantId,
                cancellationToken);

        if (template is null)
        {
            return Result.Failure<Guid>(WorkoutTemplateErrors.NotFound(command.TemplateId));
        }

        Guid ownerStudentId = command.OwnerStudentId == Guid.Empty
            ? userContext.UserId
            : command.OwnerStudentId;

        var workout = new Workout
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            OwnerStudentId = ownerStudentId,
            SourceTemplateId = template.Id,
            Name = string.IsNullOrWhiteSpace(command.NameOverride) ? template.Name : command.NameOverride,
            Description = template.Description,
            ModalityId = template.ModalityId,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        foreach (TemplateItem item in template.Items.OrderBy(i => i.Order))
        {
            workout.Items.Add(new WorkoutItem
            {
                Id = Guid.NewGuid(),
                WorkoutId = workout.Id,
                ExerciseId = item.ExerciseId,
                Order = item.Order,
                SectionLabel = item.SectionLabel,
                Sets = item.Sets,
                Reps = item.Reps,
                RestSeconds = item.RestSeconds,
                DurationSeconds = item.DurationSeconds,
                WorkSeconds = item.WorkSeconds,
                IntervalRestSeconds = item.IntervalRestSeconds,
                Rounds = item.Rounds,
                ProfessorComment = item.CreatorNotes,
            });
        }

        dbContext.Workouts.Add(workout);
        await dbContext.SaveChangesAsync(cancellationToken);

        return workout.Id;
    }
}
