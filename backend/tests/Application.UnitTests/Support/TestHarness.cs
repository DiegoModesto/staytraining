using Application.Abstractions.Authentication;
using Infra.Database;
using Microsoft.EntityFrameworkCore;

namespace Application.UnitTests.Support;

/// <summary>Deterministic fake of <see cref="IUserContext"/> for handler tests.</summary>
public sealed class FakeUserContext(Guid? tenantId, Guid userId) : IUserContext
{
    public Guid UserId { get; } = userId;
    public Guid? TenantId { get; } = tenantId;
    public bool IsAuthenticated => true;
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

    public static FakeUserContext User(Guid tenantId, Guid? userId = null) =>
        new(tenantId, userId ?? Guid.NewGuid());
}
