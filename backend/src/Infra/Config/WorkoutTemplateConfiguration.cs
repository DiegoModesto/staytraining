using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infra.Config;

internal sealed class WorkoutTemplateConfiguration : AbstractConfiguration<WorkoutTemplate>
{
    public override void Configure(EntityTypeBuilder<WorkoutTemplate> builder)
    {
        base.Configure(builder);

        builder.ToTable("workout_templates");

        builder.HasKey(e => e.Id);

        builder.Property(e => e.TenantId).IsRequired();
        builder.HasIndex(e => new { e.TenantId, e.IsSystemDefault });

        builder.Property(e => e.Name).IsRequired().HasMaxLength(200);
        builder.Property(e => e.Description).HasMaxLength(2000);
        builder.Property(e => e.CreatorNotes).HasMaxLength(4000);
        builder.Property(e => e.IsSystemDefault).IsRequired();

        builder.HasOne(e => e.Modality)
            .WithMany()
            .HasForeignKey(e => e.ModalityId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasMany(e => e.Items)
            .WithOne()
            .HasForeignKey(i => i.WorkoutTemplateId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}

internal sealed class TemplateItemConfiguration : IEntityTypeConfiguration<TemplateItem>
{
    public void Configure(EntityTypeBuilder<TemplateItem> builder)
    {
        builder.ToTable("template_items");

        builder.HasKey(i => i.Id);

        builder.Property(i => i.WorkoutTemplateId).IsRequired();
        builder.Property(i => i.ExerciseId).IsRequired();
        builder.Property(i => i.SectionLabel).HasMaxLength(100);
        builder.Property(i => i.CreatorNotes).HasMaxLength(2000);

        builder.HasIndex(i => i.WorkoutTemplateId);
    }
}
