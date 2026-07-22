using MudBlazor;

namespace Web.Blazor.Theme;

/// <summary>
/// The StayTraining "VOLT" design system as a MudBlazor theme — athletic, dark-first, with an
/// electric volt accent. Display type is Archivo (headings/buttons), body is Hanken Grotesk.
/// See the published style guide for the full spec. Category colors live in <see cref="Category"/>
/// so chips/icons/agenda can color-code Musculação / Funcional / Boxe / Aeróbico consistently.
/// </summary>
public static class StayTrainingTheme
{
    private static readonly string[] Display = ["Archivo", "system-ui", "sans-serif"];
    private static readonly string[] Body = ["Hanken Grotesk", "system-ui", "sans-serif"];

    /// <summary>Per-modality accent colors (hex), keyed by <c>ExerciseCategory</c> name.</summary>
    public static class Category
    {
        public const string Musculacao = "#4EA8FF";
        public const string Funcional = "#2FD37A";
        public const string Boxe = "#FF4757";
        public const string Aerobico = "#FFB020";

        public static string For(string category) => category switch
        {
            "Musculacao" => Musculacao,
            "Funcional" => Funcional,
            "Boxe" => Boxe,
            "Aerobico" => Aerobico,
            _ => "#9AA4B2",
        };
    }

    public static readonly MudTheme Instance = new()
    {
        PaletteLight = new PaletteLight
        {
            Primary = "#A6D400",              // volt-deep reads better on light surfaces
            PrimaryContrastText = "#0C0E12",
            Secondary = "#FF5A3C",
            Tertiary = "#4EA8FF",
            Background = "#F4F5F1",
            Surface = "#FFFFFF",
            AppbarBackground = "#131720",     // strong dark branded top bar
            AppbarText = "#F2F5F7",
            DrawerBackground = "#FFFFFF",
            DrawerText = "#131720",
            TextPrimary = "#131720",
            TextSecondary = "#54606F",
            Success = "#2FD37A",
            Warning = "#FFB020",
            Error = "#FF4757",
            Info = "#4EA8FF",
            LinesDefault = "#E4E7E0",
            TableLines = "#E4E7E0",
            Divider = "#E4E7E0",
        },
        PaletteDark = new PaletteDark
        {
            Primary = "#C7F536",
            PrimaryContrastText = "#0C0E12",
            Secondary = "#FF5A3C",
            Tertiary = "#4EA8FF",
            Background = "#0C0E12",
            Surface = "#14171D",
            AppbarBackground = "#14171D",
            AppbarText = "#F2F5F7",
            DrawerBackground = "#0C0E12",
            DrawerText = "#F2F5F7",
            TextPrimary = "#F2F5F7",
            TextSecondary = "#9AA4B2",
            ActionDefault = "#9AA4B2",
            Success = "#2FD37A",
            Warning = "#FFB020",
            Error = "#FF4757",
            Info = "#4EA8FF",
            LinesDefault = "#2A313C",
            TableLines = "#2A313C",
            Divider = "#2A313C",
            DrawerIcon = "#9AA4B2",
        },
        Typography = new Typography
        {
            Default = new DefaultTypography { FontFamily = Body, FontWeight = "400", LineHeight = "1.55" },
            H1 = new H1Typography { FontFamily = Display, FontWeight = "800", LetterSpacing = "-.02em" },
            H2 = new H2Typography { FontFamily = Display, FontWeight = "800", LetterSpacing = "-.02em" },
            H3 = new H3Typography { FontFamily = Display, FontWeight = "800", LetterSpacing = "-.01em" },
            H4 = new H4Typography { FontFamily = Display, FontWeight = "700", LetterSpacing = "-.01em" },
            H5 = new H5Typography { FontFamily = Display, FontWeight = "700" },
            H6 = new H6Typography { FontFamily = Display, FontWeight = "700" },
            Subtitle1 = new Subtitle1Typography { FontFamily = Body, FontWeight = "600" },
            Subtitle2 = new Subtitle2Typography { FontFamily = Body, FontWeight = "600" },
            Body1 = new Body1Typography { FontFamily = Body },
            Body2 = new Body2Typography { FontFamily = Body },
            Button = new ButtonTypography { FontFamily = Display, FontWeight = "700", LetterSpacing = ".04em" },
            Caption = new CaptionTypography { FontFamily = Body },
            Overline = new OverlineTypography { FontFamily = Display, FontWeight = "700", LetterSpacing = ".12em" },
        },
        LayoutProperties = new LayoutProperties
        {
            DefaultBorderRadius = "12px",
            DrawerWidthLeft = "240px",
            DrawerMiniWidthLeft = "68px",
        },
    };
}
