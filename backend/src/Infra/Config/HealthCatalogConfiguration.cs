using Domain.HealthCatalog;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infra.Config;

internal sealed class BodyPartConfiguration : AbstractConfiguration<BodyPart>
{
    public override void Configure(EntityTypeBuilder<BodyPart> builder)
    {
        base.Configure(builder);

        builder.ToTable("body_parts");
        builder.HasKey(b => b.Id);

        builder.Property(b => b.Name).IsRequired().HasMaxLength(80);
        builder.HasIndex(b => b.Name).IsUnique();
        builder.Property(b => b.SortOrder).IsRequired();

        builder.HasMany(b => b.ProblemTypes)
            .WithOne()
            .HasForeignKey(p => p.BodyPartId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}

internal sealed class ProblemTypeConfiguration : AbstractConfiguration<ProblemType>
{
    public override void Configure(EntityTypeBuilder<ProblemType> builder)
    {
        base.Configure(builder);

        builder.ToTable("problem_types");
        builder.HasKey(p => p.Id);

        builder.Property(p => p.BodyPartId).IsRequired();
        builder.Property(p => p.Name).IsRequired().HasMaxLength(120);
        builder.Property(p => p.SortOrder).IsRequired();

        builder.HasIndex(p => new { p.BodyPartId, p.Name }).IsUnique();
    }
}
