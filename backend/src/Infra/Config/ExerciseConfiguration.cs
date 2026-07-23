using Domain.Exercises;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infra.Config;

internal sealed class ExerciseConfiguration : AbstractConfiguration<Exercise>
{
    public override void Configure(EntityTypeBuilder<Exercise> builder)
    {
        base.Configure(builder);

        builder.ToTable("exercises");

        builder.HasKey(e => e.Id);

        builder.Property(e => e.TenantId).IsRequired();
        builder.HasIndex(e => new { e.TenantId, e.Id });
        builder.HasIndex(e => new { e.TenantId, e.ModalityId });

        builder.Property(e => e.Name).IsRequired().HasMaxLength(200);
        builder.Property(e => e.Description).HasMaxLength(2000);
        builder.Property(e => e.UsageExample).HasMaxLength(4000);

        builder.Property(e => e.ModalityId).IsRequired();
        builder.HasOne(e => e.Modality)
            .WithMany()
            .HasForeignKey(e => e.ModalityId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Property(e => e.PrimaryMuscleGroupId).IsRequired();

        // EF Core primitive collection — mapped to jsonb by Npgsql.
        builder.Property(e => e.SecondaryMuscleGroupIds);

        builder.Property(e => e.DefaultSets);
        builder.Property(e => e.DefaultReps);
        builder.Property(e => e.DefaultRestSeconds);
        builder.Property(e => e.IsAerobic).IsRequired();
        builder.Property(e => e.DefaultWorkSeconds);
        builder.Property(e => e.DefaultIntervalRestSeconds);
        builder.Property(e => e.DefaultRounds);

        builder.HasMany(e => e.Media)
            .WithOne()
            .HasForeignKey(m => m.ExerciseId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}

internal sealed class ExerciseMediaConfiguration : IEntityTypeConfiguration<ExerciseMedia>
{
    public void Configure(EntityTypeBuilder<ExerciseMedia> builder)
    {
        builder.ToTable("exercise_media");

        builder.HasKey(m => m.Id);

        builder.Property(m => m.ExerciseId).IsRequired();
        builder.Property(m => m.Kind).HasConversion<string>().HasMaxLength(30);
        builder.Property(m => m.StorageKey).HasMaxLength(1024);
        builder.Property(m => m.Url).HasMaxLength(2048);
        builder.Property(m => m.ContentType).HasMaxLength(255);

        builder.HasIndex(m => m.ExerciseId);
    }
}
