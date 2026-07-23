namespace Web.Blazor.Training;

/// <summary>
/// UI helper for rendering a <see cref="ModalityDto"/> (label + VOLT accent color). Modalities are
/// now admin-managed data, so pages resolve the <see cref="ModalityDto"/> from the loaded catalog
/// (by id) and pass it here — there is no fixed enum anymore.
/// </summary>
public static class CategoryDisplay
{
    private const string Fallback = "#9AA4B2";

    public static string Label(ModalityDto? modality) => modality?.Name ?? "—";

    public static string Color(ModalityDto? modality) =>
        string.IsNullOrWhiteSpace(modality?.ColorHex) ? Fallback : modality!.ColorHex;

    public static bool IsIntervalBased(ModalityDto? modality) => modality?.IsIntervalBased ?? false;
}
