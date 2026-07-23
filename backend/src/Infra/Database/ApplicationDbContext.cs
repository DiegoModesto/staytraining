using Application.Abstractions.Data;
using Domain.Devices;
using Domain.Execution;
using Domain.Exercises;
using Domain.HealthCatalog;
using Domain.Modalities;
using Domain.MuscleGroups;
using Domain.Profiles;
using Domain.SampleEntities;
using Domain.Students;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Infra.Database;

public sealed class ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
    : DbContext(options), IApplicationDbContext
{
    public DbSet<SampleEntity> SampleEntities { get; set; }

    public DbSet<UserProfile> UserProfiles { get; set; }
    public DbSet<Modality> Modalities { get; set; }
    public DbSet<MuscleGroup> MuscleGroups { get; set; }
    public DbSet<Exercise> Exercises { get; set; }
    public DbSet<ExerciseMedia> ExerciseMedia { get; set; }

    public DbSet<WorkoutTemplate> WorkoutTemplates { get; set; }
    public DbSet<TemplateItem> TemplateItems { get; set; }
    public DbSet<Workout> Workouts { get; set; }
    public DbSet<WorkoutItem> WorkoutItems { get; set; }

    public DbSet<WorkoutSchedule> WorkoutSchedules { get; set; }
    public DbSet<WorkoutSession> WorkoutSessions { get; set; }
    public DbSet<ExerciseNote> ExerciseNotes { get; set; }

    public DbSet<DeviceToken> DeviceTokens { get; set; }

    public DbSet<StudentProfile> StudentProfiles { get; set; }
    public DbSet<HealthApportment> HealthApportments { get; set; }
    public DbSet<StudentNote> StudentNotes { get; set; }
    public DbSet<StudentEditLog> StudentEditLogs { get; set; }

    public DbSet<BodyPart> BodyParts { get; set; }
    public DbSet<ProblemType> ProblemTypes { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Ignore<ErrorType>();

        modelBuilder.ApplyConfigurationsFromAssembly(typeof(ApplicationDbContext).Assembly);
        modelBuilder.HasDefaultSchema(Schemas.Default);
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.ConfigureWarnings(warnings =>
            warnings.Ignore(Microsoft.EntityFrameworkCore.Diagnostics.RelationalEventId.PendingModelChangesWarning));
    }

    public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        StampUpdatedAt();
        return base.SaveChangesAsync(cancellationToken);
    }

    /// <summary>Stamps <see cref="IHasUpdatedAt.UpdatedAt"/> on inserted/modified entities (delta-sync watermark).</summary>
    private void StampUpdatedAt()
    {
        DateTimeOffset now = DateTimeOffset.UtcNow;

        foreach (var entry in ChangeTracker.Entries<IHasUpdatedAt>()
            .Where(e => e.State is EntityState.Added or EntityState.Modified))
        {
            entry.Entity.UpdatedAt = now;
        }
    }
}
