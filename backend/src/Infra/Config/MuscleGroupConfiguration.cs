using Domain.MuscleGroups;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infra.Config;

internal sealed class MuscleGroupConfiguration : AbstractConfiguration<MuscleGroup>
{
    public override void Configure(EntityTypeBuilder<MuscleGroup> builder)
    {
        base.Configure(builder);

        builder.ToTable("muscle_groups");

        builder.HasKey(e => e.Id);

        builder.Property(e => e.Name).IsRequired().HasMaxLength(100);
        builder.Property(e => e.BodyRegion).IsRequired().HasMaxLength(100);

        builder.HasIndex(e => e.Name);
    }
}
