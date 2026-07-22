using Domain.Students;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infra.Config;

internal sealed class StudentProfileConfiguration : AbstractConfiguration<StudentProfile>
{
    public override void Configure(EntityTypeBuilder<StudentProfile> builder)
    {
        base.Configure(builder);

        builder.ToTable("student_profiles");

        builder.HasKey(e => e.Id);

        builder.Property(e => e.TenantId).IsRequired();
        builder.Property(e => e.UserId).IsRequired();
        builder.Property(e => e.FullName).IsRequired().HasMaxLength(200);
        builder.Property(e => e.Email).HasMaxLength(320);
        builder.Property(e => e.Goals).HasMaxLength(4000);

        builder.HasIndex(e => new { e.TenantId, e.UserId }).IsUnique();

        builder.HasMany(e => e.HealthObservations)
            .WithOne()
            .HasForeignKey(o => o.StudentProfileId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}

internal sealed class HealthObservationConfiguration : IEntityTypeConfiguration<HealthObservation>
{
    public void Configure(EntityTypeBuilder<HealthObservation> builder)
    {
        builder.ToTable("health_observations");

        builder.HasKey(o => o.Id);

        builder.Property(o => o.StudentProfileId).IsRequired();
        builder.Property(o => o.Kind).HasConversion<string>().HasMaxLength(20);
        builder.Property(o => o.Title).IsRequired().HasMaxLength(200);
        builder.Property(o => o.Detail).HasMaxLength(4000);
        builder.Property(o => o.CreatedAt).IsRequired();

        builder.HasIndex(o => o.StudentProfileId);
    }
}
