namespace Domain.HealthCatalog;

/// <summary>
/// Built-in seed for the health-issue catalog (body part → problem types). Ids are fixed so the seeder
/// is idempotent and other seed data (e.g. the mock student's apport) can reference them.
/// Admins can extend/edit the catalog at runtime in Configurações.
/// </summary>
public static class HealthCatalogDefaults
{
    public sealed record ProblemSeed(Guid Id, string Name);
    public sealed record BodyPartSeed(Guid Id, string Name, int SortOrder, IReadOnlyList<ProblemSeed> Problems);

    // A specific problem type referenced by the mock student seed (Ombro → Deslocamento).
    public static readonly Guid OmbroDeslocamentoId = Guid.Parse("21000000-0000-0000-0000-000000000003");
    public static readonly Guid OmbroId = Guid.Parse("20000000-0000-0000-0000-000000000002");

    public static IReadOnlyList<BodyPartSeed> All { get; } =
    [
        new(Guid.Parse("20000000-0000-0000-0000-000000000001"), "Coração", 0,
        [
            new(Guid.Parse("21000000-0000-0000-0000-000000000001"), "Cardíaco"),
            new(Guid.Parse("21000000-0000-0000-0000-000000000002"), "Arritmia"),
        ]),
        new(OmbroId, "Ombro", 1,
        [
            new(Guid.Parse("21000000-0000-0000-0000-000000000004"), "Clavícula"),
            new(OmbroDeslocamentoId, "Deslocamento"),
            new(Guid.Parse("21000000-0000-0000-0000-000000000005"), "Tendinite"),
        ]),
        new(Guid.Parse("20000000-0000-0000-0000-000000000003"), "Lombar", 2,
        [
            new(Guid.Parse("21000000-0000-0000-0000-000000000006"), "Hérnia de disco"),
            new(Guid.Parse("21000000-0000-0000-0000-000000000007"), "Lombalgia"),
        ]),
        new(Guid.Parse("20000000-0000-0000-0000-000000000004"), "Joelho", 3,
        [
            new(Guid.Parse("21000000-0000-0000-0000-000000000008"), "Menisco"),
            new(Guid.Parse("21000000-0000-0000-0000-000000000009"), "Ligamento cruzado (LCA)"),
        ]),
        new(Guid.Parse("20000000-0000-0000-0000-000000000005"), "Punho", 4,
        [
            new(Guid.Parse("21000000-0000-0000-0000-00000000000a"), "Tendinite"),
        ]),
    ];
}
