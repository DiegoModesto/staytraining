using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infra.Config;

internal sealed class WorkoutConfiguration : AbstractConfiguration<Workout>
{
    public override void Configure(EntityTypeBuilder<Workout> builder)
    {
        base.Configure(builder);

        builder.ToTable("workouts");

        builder.HasKey(e => e.Id);

        builder.Property(e => e.TenantId).IsRequired();
        builder.Property(e => e.OwnerStudentId).IsRequired();
        builder.HasIndex(e => new { e.TenantId, e.OwnerStudentId });

        builder.Property(e => e.Name).IsRequired().HasMaxLength(200);
        builder.Property(e => e.Description).HasMaxLength(2000);
        builder.Property(e => e.Category).HasConversion<string>().HasMaxLength(30);

        builder.HasMany(e => e.Items)
            .WithOne()
            .HasForeignKey(i => i.WorkoutId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}

internal sealed class WorkoutItemConfiguration : IEntityTypeConfiguration<WorkoutItem>
{
    public void Configure(EntityTypeBuilder<WorkoutItem> builder)
    {
        builder.ToTable("workout_items");

        builder.HasKey(i => i.Id);

        builder.Property(i => i.WorkoutId).IsRequired();
        builder.Property(i => i.ExerciseId).IsRequired();
        builder.Property(i => i.SectionLabel).HasMaxLength(100);
        builder.Property(i => i.ProfessorComment).HasMaxLength(2000);

        builder.HasIndex(i => i.WorkoutId);
    }
}
