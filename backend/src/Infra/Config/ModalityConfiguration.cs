using Domain.Modalities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infra.Config;

internal sealed class ModalityConfiguration : AbstractConfiguration<Modality>
{
    public override void Configure(EntityTypeBuilder<Modality> builder)
    {
        base.Configure(builder);

        builder.ToTable("modalities");

        builder.HasKey(m => m.Id);

        builder.Property(m => m.Name).IsRequired().HasMaxLength(60);
        builder.HasIndex(m => m.Name).IsUnique();

        builder.Property(m => m.ColorHex).IsRequired().HasMaxLength(9);
        builder.Property(m => m.IsIntervalBased).IsRequired();
        builder.Property(m => m.SortOrder).IsRequired();
    }
}
