using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Domain.Workouts;
using SharedKernel;

namespace Application.Workouts.Templates.Create;

public sealed class CreateWorkoutTemplateCommandHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : ICommandHandler<CreateWorkoutTemplateCommand, Guid>
{
    public async Task<Result<Guid>> Handle(
        CreateWorkoutTemplateCommand command,
        CancellationToken cancellationToken)
    {
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to create a WorkoutTemplate.");

        var template = new WorkoutTemplate
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            Name = command.Name,
            Description = command.Description,
            Category = command.Category,
            IsSystemDefault = command.IsSystemDefault,
            CreatorNotes = command.CreatorNotes,
            CreatedAt = DateTimeOffset.UtcNow,
        };

        foreach (TemplateItemInput item in command.Items)
        {
            template.Items.Add(new TemplateItem
            {
                Id = Guid.NewGuid(),
                WorkoutTemplateId = template.Id,
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
                CreatorNotes = item.CreatorNotes,
            });
        }

        dbContext.WorkoutTemplates.Add(template);
        await dbContext.SaveChangesAsync(cancellationToken);

        return template.Id;
    }
}
