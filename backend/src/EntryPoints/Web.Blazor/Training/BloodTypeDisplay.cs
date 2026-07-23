namespace Web.Blazor.Training;

public static class BloodTypeDisplay
{
    public static string Label(BloodType type) => type switch
    {
        BloodType.APositive => "A+",
        BloodType.ANegative => "A−",
        BloodType.BPositive => "B+",
        BloodType.BNegative => "B−",
        BloodType.AbPositive => "AB+",
        BloodType.AbNegative => "AB−",
        BloodType.OPositive => "O+",
        BloodType.ONegative => "O−",
        _ => "Não informado",
    };

    public static IReadOnlyList<BloodType> All { get; } = Enum.GetValues<BloodType>();
}
