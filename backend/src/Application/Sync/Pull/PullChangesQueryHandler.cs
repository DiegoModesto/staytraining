using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Application.Exercises;
using Application.MuscleGroups.List;
using Application.Workouts;
using Domain.Exercises;
using Domain.MuscleGroups;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Sync.Pull;

public sealed class PullChangesQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<PullChangesQuery, SyncPullResponse>
{
    public async Task<Result<SyncPullResponse>> Handle(
        PullChangesQuery query,
        CancellationToken cancellationToken)
    {
        DateTimeOffset serverTime = DateTimeOffset.UtcNow;
        DateTimeOffset since = query.Since ?? DateTimeOffset.MinValue;
        Guid tenantId = userContext.TenantId
            ?? throw new InvalidOperationException("TenantId is required to sync.");
        Guid studentId = userContext.UserId;

        // Muscle groups (global reference data).
        List<MuscleGroup> muscleGroups = await dbContext.MuscleGroups
            .IgnoreQueryFilters()
            .Where(m => m.UpdatedAt > since)
            .ToListAsync(cancellationToken);

        // Exercises (tenant catalog).
        List<Exercise> exercises = await dbContext.Exercises
            .IgnoreQueryFilters()
            .Include(e => e.Media)
            .Include(e => e.Modality)
            .Where(e => e.TenantId == tenantId && e.UpdatedAt > since)
            .ToListAsync(cancellationToken);

        // Templates (tenant, including system defaults).
        List<WorkoutTemplate> templates = await dbContext.WorkoutTemplates
            .IgnoreQueryFilters()
            .Include(t => t.Items)
            .Include(t => t.Modality)
            .Where(t => t.TenantId == tenantId && t.UpdatedAt > since)
            .ToListAsync(cancellationToken);

        // Workouts owned by this student.
        List<Workout> workouts = await dbContext.Workouts
            .IgnoreQueryFilters()
            .Include(w => w.Items)
            .Include(w => w.Modality)
            .Where(w => w.TenantId == tenantId && w.OwnerStudentId == studentId && w.UpdatedAt > since)
            .ToListAsync(cancellationToken);

        // Schedules for this student.
        var schedules = await dbContext.WorkoutSchedules
            .IgnoreQueryFilters()
            .Where(s => s.TenantId == tenantId && s.StudentId == studentId && s.UpdatedAt > since)
            .Select(s => new { s.Id, s.ScheduledDate, s.WorkoutId, s.IsDeleted })
            .ToListAsync(cancellationToken);

        var response = new SyncPullResponse(
            serverTime,
            muscleGroups.Where(m => !m.IsDeleted)
                .Select(m => new MuscleGroupResponse(m.Id, m.Name, m.BodyRegion)).ToList(),
            muscleGroups.Where(m => m.IsDeleted).Select(m => m.Id).ToList(),
            exercises.Where(e => !e.IsDeleted).Select(MapExercise).ToList(),
            exercises.Where(e => e.IsDeleted).Select(e => e.Id).ToList(),
            templates.Where(t => !t.IsDeleted).Select(MapTemplate).ToList(),
            templates.Where(t => t.IsDeleted).Select(t => t.Id).ToList(),
            workouts.Where(w => !w.IsDeleted).Select(MapWorkout).ToList(),
            workouts.Where(w => w.IsDeleted).Select(w => w.Id).ToList(),
            schedules.Where(s => !s.IsDeleted)
                .Select(s => new ScheduleSyncItem(s.Id, s.ScheduledDate, s.WorkoutId)).ToList(),
            schedules.Where(s => s.IsDeleted).Select(s => s.Id).ToList());

        return response;
    }

    private static ExerciseResponse MapExercise(Exercise e) => new(
        e.Id, e.Name, e.Description, e.ModalityId, e.Modality?.Name ?? string.Empty,
        e.PrimaryMuscleGroupId, e.SecondaryMuscleGroupIds,
        e.UsageExample, e.DefaultSets, e.DefaultReps, e.DefaultRestSeconds, e.IsAerobic,
        e.DefaultWorkSeconds, e.DefaultIntervalRestSeconds, e.DefaultRounds,
        e.Media.Select(m => new ExerciseMediaResponse(
            m.Id, m.Kind, m.StorageKey, m.Url, m.ContentType, m.SizeBytes)).ToList());

    private static WorkoutTemplateResponse MapTemplate(WorkoutTemplate t) => new(
        t.Id, t.Name, t.Description, t.ModalityId, t.Modality?.Name, t.IsSystemDefault, t.CreatorNotes,
        t.Items.OrderBy(i => i.Order).Select(i => new TemplateItemResponse(
            i.Id, i.ExerciseId, i.Order, i.SectionLabel, i.Sets, i.Reps, i.RestSeconds,
            i.DurationSeconds, i.WorkSeconds, i.IntervalRestSeconds, i.Rounds, i.CreatorNotes)).ToList());

    private static WorkoutResponse MapWorkout(Workout w) => new(
        w.Id, w.OwnerStudentId, w.SourceTemplateId, w.Name, w.Description, w.ModalityId, w.Modality?.Name,
        w.Items.OrderBy(i => i.Order).Select(i => new WorkoutItemResponse(
            i.Id, i.ExerciseId, i.Order, i.SectionLabel, i.Sets, i.Reps, i.RestSeconds,
            i.DurationSeconds, i.WorkSeconds, i.IntervalRestSeconds, i.Rounds, i.ProfessorComment)).ToList());
}
