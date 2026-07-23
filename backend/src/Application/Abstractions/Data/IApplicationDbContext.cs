using Domain.Devices;
using Domain.Execution;
using Domain.Exercises;
using Domain.HealthCatalog;
using Domain.Modalities;
using Domain.MuscleGroups;
using Domain.Profiles;
using Domain.Questions;
using Domain.SampleEntities;
using Domain.Students;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;

namespace Application.Abstractions.Data;

public interface IApplicationDbContext
{
    DbSet<SampleEntity> SampleEntities { get; }

    DbSet<UserProfile> UserProfiles { get; }
    DbSet<Modality> Modalities { get; }
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
    DbSet<HealthApportment> HealthApportments { get; }
    DbSet<StudentNote> StudentNotes { get; }
    DbSet<StudentEditLog> StudentEditLogs { get; }

    DbSet<BodyPart> BodyParts { get; }
    DbSet<ProblemType> ProblemTypes { get; }

    DbSet<Question> Questions { get; }

    Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
}
