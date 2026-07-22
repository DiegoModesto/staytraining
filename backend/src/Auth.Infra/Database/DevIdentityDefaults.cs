using Auth.Domain.Permissions;

namespace Auth.Infra.Database;

/// <summary>
/// Fixed identifiers for the Development-only stand-alone login (no Microsoft Entra needed).
/// The tenant and user ids are deliberately aligned with the Web.API training seed
/// (<c>Infra.Database.SeedDataHostedService</c>): the tenant's internal id is <c>1111…</c> and the
/// mock users are <c>2222…</c> (professor) / <c>3333…</c> (student), so a token minted by the dev
/// login carries <c>tenant_id=1111…</c> and <c>sub=2222…/3333…</c> — the same ids the training data
/// is seeded under. A logged-in mock user therefore sees their own seeded data end-to-end.
/// </summary>
public static class DevIdentityDefaults
{
    /// <summary>Both the tenant's internal <c>Id</c> and its <c>EntraTenantId</c> (the <c>tid</c> claim).</summary>
    public static readonly Guid TenantId = Guid.Parse("11111111-1111-1111-1111-111111111111");

    /// <summary>A selectable mock identity on the dev login page.</summary>
    public sealed record DevUser(
        Guid UserId,
        Guid EntraOid,
        string Email,
        string DisplayName,
        string RoleName,
        IReadOnlyCollection<string> Permissions);

    public static readonly DevUser Professor = new(
        UserId: Guid.Parse("22222222-2222-2222-2222-222222222222"),
        EntraOid: Guid.Parse("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"),
        Email: "diego.modesto@example.com",
        DisplayName: "Diego Modesto",
        RoleName: "Professor",
        Permissions: PermissionCodes.TeacherRole);

    public static readonly DevUser Student = new(
        UserId: Guid.Parse("33333333-3333-3333-3333-333333333333"),
        EntraOid: Guid.Parse("bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"),
        Email: "rita.modesto@example.com",
        DisplayName: "Rita Sibele Modesto",
        RoleName: "Aluno",
        Permissions: PermissionCodes.StudentRole);

    public static readonly IReadOnlyList<DevUser> All = [Professor, Student];
}
