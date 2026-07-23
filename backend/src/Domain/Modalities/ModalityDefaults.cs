namespace Domain.Modalities;

/// <summary>
/// The four built-in modalities that replaced the legacy <c>ExerciseCategory</c> enum. Their ids are
/// FIXED so the EF migration can back-fill existing exercises/workouts/templates and the seeder can
/// reference them deterministically. <c>LegacyCode</c> matches the string the old enum column stored,
/// which is how the migration maps rows onto the new foreign key.
/// </summary>
public static class ModalityDefaults
{
    public static readonly Guid MusculacaoId = Guid.Parse("10000000-0000-0000-0000-000000000001");
    public static readonly Guid FuncionalId = Guid.Parse("10000000-0000-0000-0000-000000000002");
    public static readonly Guid BoxeId = Guid.Parse("10000000-0000-0000-0000-000000000003");
    public static readonly Guid AerobicoId = Guid.Parse("10000000-0000-0000-0000-000000000004");

    public sealed record Seed(Guid Id, string Name, string ColorHex, bool IsIntervalBased, int SortOrder, string LegacyCode);

    public static IReadOnlyList<Seed> All { get; } =
    [
        new(MusculacaoId, "Musculação", "#4EA8FF", false, 0, "Musculacao"),
        new(FuncionalId, "Funcional", "#2FD37A", false, 1, "Funcional"),
        new(BoxeId, "Boxe", "#FF4757", true, 2, "Boxe"),
        new(AerobicoId, "Aeróbico", "#FFB020", true, 3, "Aerobico"),
    ];
}
