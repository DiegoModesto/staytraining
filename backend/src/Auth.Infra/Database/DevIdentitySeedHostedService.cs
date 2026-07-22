using Auth.Application.Abstractions.Data;
using Auth.Domain.Roles;
using Auth.Domain.Tenants;
using Auth.Domain.Users;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace Auth.Infra.Database;

/// <summary>
/// Development-only seed that makes the Auth.API usable stand-alone (no Microsoft Entra):
/// it ensures a local tenant plus the mock professor/student users from
/// <see cref="DevIdentityDefaults"/>, each with a role carrying its permission set. The dev login
/// page then signs a mock identity in, and the normal OpenIddict authorize flow resolves this
/// tenant/user and mints a real token. Idempotent — only inserts what is missing.
///
/// Registered only in Development (see <c>Auth.Infra.DependencyInjection.AddAuthDevIdentitySeeding</c>)
/// and after <see cref="PermissionSeedHostedService"/>, so the permission catalog it references exists.
/// The fixed internal ids can't be set through the domain factories (they assign a random Guid), so
/// they are stamped via reflection here — contained to this dev-only seeder, keeping the domain pure.
/// </summary>
internal sealed class DevIdentitySeedHostedService(
    IServiceScopeFactory scopeFactory,
    ILogger<DevIdentitySeedHostedService> logger)
    : IHostedService
{
    public async Task StartAsync(CancellationToken cancellationToken)
    {
        using IServiceScope scope = scopeFactory.CreateScope();
        IAuthDbContext db = scope.ServiceProvider.GetRequiredService<IAuthDbContext>();

        await EnsureTenantAsync(db, cancellationToken);

        Dictionary<string, Guid> permissionIdByCode = await db.Permissions
            .ToDictionaryAsync(p => p.Code, p => p.Id, cancellationToken);

        foreach (DevIdentityDefaults.DevUser mock in DevIdentityDefaults.All)
        {
            Guid roleId = await EnsureRoleAsync(db, mock, permissionIdByCode, cancellationToken);
            await EnsureUserAsync(db, mock, roleId, cancellationToken);
        }

        logger.LogInformation(
            "Dev identity seed: tenant {TenantId} and {Count} mock users ensured.",
            DevIdentityDefaults.TenantId,
            DevIdentityDefaults.All.Count);
    }

    public Task StopAsync(CancellationToken cancellationToken) => Task.CompletedTask;

    private static async Task EnsureTenantAsync(IAuthDbContext db, CancellationToken ct)
    {
        bool exists = await db.Tenants.AnyAsync(t => t.Id == DevIdentityDefaults.TenantId, ct);
        if (exists)
        {
            return;
        }

        // DefaultRedirectUri is not consulted by the authorize flow (OpenIddict uses the client's
        // registered redirect_uri); it only needs to be non-empty for the tenant aggregate.
        Tenant tenant = Tenant.Create(
            entraTenantId: DevIdentityDefaults.TenantId,
            displayName: "Local Dev Tenant",
            defaultRedirectUri: "/signin-oidc");
        ForceId(tenant, DevIdentityDefaults.TenantId);

        db.Tenants.Add(tenant);
        await db.SaveChangesAsync(ct);
    }

    private static async Task<Guid> EnsureRoleAsync(
        IAuthDbContext db,
        DevIdentityDefaults.DevUser mock,
        Dictionary<string, Guid> permissionIdByCode,
        CancellationToken ct)
    {
        Role? role = await db.Roles.FirstOrDefaultAsync(
            r => r.TenantId == DevIdentityDefaults.TenantId && r.Name == mock.RoleName, ct);
        if (role is not null)
        {
            return role.Id;
        }

        role = Role.Create(DevIdentityDefaults.TenantId, mock.RoleName, $"Dev {mock.RoleName} role");
        foreach (string code in mock.Permissions)
        {
            if (permissionIdByCode.TryGetValue(code, out Guid permissionId))
            {
                role.AssignPermission(permissionId);
            }
        }

        db.Roles.Add(role);
        await db.SaveChangesAsync(ct);   // reconciles role_permissions join rows
        return role.Id;
    }

    private static async Task EnsureUserAsync(
        IAuthDbContext db,
        DevIdentityDefaults.DevUser mock,
        Guid roleId,
        CancellationToken ct)
    {
        bool exists = await db.Users.AnyAsync(u => u.Id == mock.UserId, ct);
        if (exists)
        {
            return;
        }

        User user = User.ProvisionFromEntra(
            DevIdentityDefaults.TenantId, mock.EntraOid, mock.Email, mock.DisplayName);
        ForceId(user, mock.UserId);
        user.AssignRole(roleId);

        db.Users.Add(user);
        await db.SaveChangesAsync(ct);   // reconciles user_roles join rows
    }

    /// <summary>
    /// Overwrites the private-set <c>Id</c> the domain factory assigned, so dev ids stay fixed and
    /// aligned with the Web.API training seed. Dev-only; never used in production code paths.
    /// </summary>
    private static void ForceId<T>(T entity, Guid id)
    {
        System.Reflection.PropertyInfo idProperty = typeof(T).GetProperty("Id")
            ?? throw new InvalidOperationException($"{typeof(T).Name} has no Id property.");
        idProperty.SetValue(entity, id);
    }
}
