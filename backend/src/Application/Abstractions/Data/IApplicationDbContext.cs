using Domain.Devices;
using Domain.Execution;
using Domain.Exercises;
using Domain.MuscleGroups;
using Domain.SampleEntities;
using Domain.Students;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;

namespace Application.Abstractions.Data;

public interface IApplicationDbContext
{
    DbSet<SampleEntity> SampleEntities { get; }

    DbSet<MuscleGroup> MuscleGroups { get; }
    DbSet<Exercise> Exercises { get; }
    DbSet<ExerciseMedia> ExerciseMedia { get; }

    DbSet<WorkoutTemplate> WorkoutTemplates { get; }
    DbSet<TemplateItem> TemplateItems { get; }
    DbSet<Workout> Workouts { get; }
    DbSet<WorkoutItem> WorkoutItems { get; }

    DbSet<WorkoutSchedule> WorkoutSchedules { get; }
    DbSet<WorkoutSession> WorkoutSessions { get; }
    DbSet<ExerciseNote> ExerciseNotes { get; }

    DbSet<DeviceToken> DeviceTokens { get; }

    DbSet<StudentProfile> StudentProfiles { get; }
    DbSet<HealthObservation> HealthObservations { get; }
    DbSet<StudentNote> StudentNotes { get; }

    Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
}
