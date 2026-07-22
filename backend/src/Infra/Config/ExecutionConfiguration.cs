using Domain.Execution;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infra.Config;

internal sealed class WorkoutScheduleConfiguration : AbstractConfiguration<WorkoutSchedule>
{
    public override void Configure(EntityTypeBuilder<WorkoutSchedule> builder)
    {
        base.Configure(builder);

        builder.ToTable("workout_schedules");

        builder.HasKey(e => e.Id);

        builder.Property(e => e.TenantId).IsRequired();
        builder.Property(e => e.StudentId).IsRequired();
        builder.Property(e => e.WorkoutId).IsRequired();
        builder.Property(e => e.ScheduledDate).IsRequired();

        builder.HasIndex(e => new { e.TenantId, e.StudentId, e.ScheduledDate });
    }
}

internal sealed class WorkoutSessionConfiguration : AbstractConfiguration<WorkoutSession>
{
    public override void Configure(EntityTypeBuilder<WorkoutSession> builder)
    {
        base.Configure(builder);

        builder.ToTable("workout_sessions");

        builder.HasKey(e => e.Id);

        builder.Property(e => e.TenantId).IsRequired();
        builder.Property(e => e.StudentId).IsRequired();
        builder.Property(e => e.WorkoutId).IsRequired();
        builder.Property(e => e.StartedAt).IsRequired();
        builder.Property(e => e.OverallComment).HasMaxLength(4000);

        builder.HasIndex(e => new { e.TenantId, e.StudentId, e.WorkoutId, e.StartedAt });

        builder.HasMany(e => e.Notes)
            .WithOne()
            .HasForeignKey(n => n.WorkoutSessionId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}

internal sealed class ExerciseNoteConfiguration : IEntityTypeConfiguration<ExerciseNote>
{
    public void Configure(EntityTypeBuilder<ExerciseNote> builder)
    {
        builder.ToTable("exercise_notes");

        builder.HasKey(n => n.Id);

        builder.Property(n => n.WorkoutSessionId).IsRequired();
        builder.Property(n => n.WorkoutItemId).IsRequired();
        builder.Property(n => n.ExerciseId).IsRequired();
        builder.Property(n => n.LoadKg).HasPrecision(7, 2);
        builder.Property(n => n.PainNote).HasMaxLength(2000);
        builder.Property(n => n.Comment).HasMaxLength(4000);
        builder.Property(n => n.CreatedAt).IsRequired();

        builder.HasIndex(n => n.WorkoutSessionId);
        builder.HasIndex(n => n.ExerciseId);

        // One note per (session, item) — upserts target this pair.
        builder.HasIndex(n => new { n.WorkoutSessionId, n.WorkoutItemId }).IsUnique();
    }
}
