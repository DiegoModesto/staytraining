using Application.Abstractions.Authentication;
using Infra.Database;
using Microsoft.EntityFrameworkCore;

namespace Application.UnitTests.Support;

/// <summary>Deterministic fake of <see cref="IUserContext"/> for handler tests.</summary>
public sealed class FakeUserContext(Guid? tenantId, Guid userId, string? name = null) : IUserContext
{
    public Guid UserId { get; } = userId;
    public Guid? TenantId { get; } = tenantId;
    public bool IsAuthenticated => true;
    public string? Name { get; } = name;
}

/// <summary>
/// Spins up the real <see cref="ApplicationDbContext"/> backed by the EF Core in-memory provider,
/// so handler tests exercise the actual entity configs, global query filters and the
/// <c>UpdatedAt</c> stamping in <c>SaveChangesAsync</c>.
/// </summary>
public static class TestHarness
{
    public static ApplicationDbContext NewContext() =>
        new(new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase($"stay-{Guid.NewGuid()}")
            .EnableSensitiveDataLogging()
            .Options);

    public static FakeUserContext User(Guid tenantId, Guid? userId = null, string? name = null) =>
        new(tenantId, userId ?? Guid.NewGuid(), name);

    /// <summary>Adds a modality to the (global) catalog and returns its id, for tests that need a valid FK.</summary>
    public static Guid SeedModality(ApplicationDbContext db, string name = "Musculação", bool isIntervalBased = false)
    {
        var modality = new Domain.Modalities.Modality
        {
            Id = Guid.NewGuid(),
            Name = name,
            ColorHex = "#4EA8FF",
            IsIntervalBased = isIntervalBased,
            CreatedAt = DateTimeOffset.UtcNow,
        };
        db.Modalities.Add(modality);
        db.SaveChanges();
        return modality.Id;
    }
}
