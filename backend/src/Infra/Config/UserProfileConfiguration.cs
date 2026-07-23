using Domain.Profiles;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infra.Config;

internal sealed class UserProfileConfiguration : AbstractConfiguration<UserProfile>
{
    public override void Configure(EntityTypeBuilder<UserProfile> builder)
    {
        base.Configure(builder);

        builder.ToTable("user_profiles");

        builder.HasKey(p => p.Id);

        builder.Property(p => p.TenantId).IsRequired();
        builder.Property(p => p.UserId).IsRequired();
        builder.HasIndex(p => new { p.TenantId, p.UserId }).IsUnique();

        builder.Property(p => p.FullName).IsRequired().HasMaxLength(200);
        builder.Property(p => p.Email).IsRequired().HasMaxLength(320);
        builder.Property(p => p.Phone).HasMaxLength(40);
        builder.Property(p => p.BloodType).HasConversion<string>().HasMaxLength(20);
        builder.Property(p => p.WeightKg).HasPrecision(5, 2);
        builder.Property(p => p.PhotoKey).HasMaxLength(1024);
    }
}
