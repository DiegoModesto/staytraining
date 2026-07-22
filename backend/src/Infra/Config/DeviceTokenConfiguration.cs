using Domain.Devices;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infra.Config;

internal sealed class DeviceTokenConfiguration : AbstractConfiguration<DeviceToken>
{
    public override void Configure(EntityTypeBuilder<DeviceToken> builder)
    {
        base.Configure(builder);

        builder.ToTable("device_tokens");

        builder.HasKey(e => e.Id);

        builder.Property(e => e.TenantId).IsRequired();
        builder.Property(e => e.UserId).IsRequired();
        builder.Property(e => e.Token).IsRequired().HasMaxLength(4096);
        builder.Property(e => e.Platform).HasConversion<string>().HasMaxLength(20);

        builder.HasIndex(e => e.Token).IsUnique();
        builder.HasIndex(e => new { e.TenantId, e.UserId });
    }
}
