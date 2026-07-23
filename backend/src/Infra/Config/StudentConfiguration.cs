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

        builder.Property(e => e.Phone).HasMaxLength(40);
        builder.Property(e => e.EmergencyPhone).HasMaxLength(40);
        builder.Property(e => e.BloodType).HasConversion<string>().HasMaxLength(20);
        builder.Property(e => e.WeightKg).HasPrecision(5, 2);
        builder.Property(e => e.PhotoKey).HasMaxLength(1024);

        builder.HasIndex(e => new { e.TenantId, e.UserId }).IsUnique();

        builder.HasMany(e => e.HealthApportments)
            .WithOne()
            .HasForeignKey(a => a.StudentProfileId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasMany(e => e.Notes)
            .WithOne()
            .HasForeignKey(n => n.StudentProfileId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasMany(e => e.EditLogs)
            .WithOne()
            .HasForeignKey(l => l.StudentProfileId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}

internal sealed class StudentNoteConfiguration : IEntityTypeConfiguration<StudentNote>
{
    public void Configure(EntityTypeBuilder<StudentNote> builder)
    {
        builder.ToTable("student_notes");

        builder.HasKey(n => n.Id);

        builder.Property(n => n.StudentProfileId).IsRequired();
        builder.Property(n => n.AuthorUserId).IsRequired();
        builder.Property(n => n.AuthorName).IsRequired().HasMaxLength(200);
        builder.Property(n => n.Content).IsRequired().HasMaxLength(4000);
        builder.Property(n => n.CreatedAt).IsRequired();

        builder.HasIndex(n => n.StudentProfileId);
        builder.HasIndex(n => new { n.StudentProfileId, n.WorkoutId });
    }
}

internal sealed class HealthApportmentConfiguration : IEntityTypeConfiguration<HealthApportment>
{
    public void Configure(EntityTypeBuilder<HealthApportment> builder)
    {
        builder.ToTable("health_apportments");

        builder.HasKey(a => a.Id);

        builder.Property(a => a.StudentProfileId).IsRequired();
        builder.Property(a => a.BodyPartId).IsRequired();
        builder.Property(a => a.BodyPartName).IsRequired().HasMaxLength(80);
        builder.Property(a => a.ProblemTypeId).IsRequired();
        builder.Property(a => a.ProblemTypeName).IsRequired().HasMaxLength(120);
        builder.Property(a => a.Observation).HasMaxLength(4000);
        builder.Property(a => a.CreatedAt).IsRequired();

        builder.HasIndex(a => a.StudentProfileId);
    }
}

internal sealed class StudentEditLogConfiguration : IEntityTypeConfiguration<StudentEditLog>
{
    public void Configure(EntityTypeBuilder<StudentEditLog> builder)
    {
        builder.ToTable("student_edit_logs");

        builder.HasKey(l => l.Id);

        builder.Property(l => l.StudentProfileId).IsRequired();
        builder.Property(l => l.EditorUserId).IsRequired();
        builder.Property(l => l.EditorName).IsRequired().HasMaxLength(200);
        builder.Property(l => l.Action).IsRequired().HasMaxLength(50);
        builder.Property(l => l.Detail).IsRequired().HasMaxLength(2000);
        builder.Property(l => l.CreatedAt).IsRequired();

        builder.HasIndex(l => l.StudentProfileId);
    }
}
