import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The StayTraining "VOLT" design system (aligned with the web backoffice theme): athletic,
/// dark-first, electric volt accent. Display type is Archivo, body is Hanken Grotesk.
class AppTheme {
  // ----- VOLT palette -----
  static const _voltLight = Color(0xFFA6D400); // reads better on light surfaces
  static const _voltDark = Color(0xFFC7F536);
  static const _ink = Color(0xFF0C0E12); // contrast text on volt
  static const _secondary = Color(0xFFFF5A3C);
  static const _tertiary = Color(0xFF4EA8FF);
  static const _error = Color(0xFFFF4757);

  static const _bgLight = Color(0xFFF4F5F1);
  static const _surfaceLight = Color(0xFFFFFFFF);
  static const _textLight = Color(0xFF131720);
  static const _textLight2 = Color(0xFF54606F);
  static const _lineLight = Color(0xFFE4E7E0);

  static const _bgDark = Color(0xFF0C0E12);
  static const _surfaceDark = Color(0xFF14171D);
  static const _textDark = Color(0xFFF2F5F7);
  static const _textDark2 = Color(0xFF9AA4B2);
  static const _lineDark = Color(0xFF2A313C);

  // Branded dark top bar in both themes (per the VOLT spec).
  static const _appBarLight = Color(0xFF131720);
  static const _appBarDark = Color(0xFF14171D);
  static const _appBarText = Color(0xFFF2F5F7);

  /// Per-modality accent colors, keyed by category name (mirrors the web theme).
  static const modalityColors = <String, Color>{
    'Musculacao': Color(0xFF4EA8FF),
    'Funcional': Color(0xFF2FD37A),
    'Boxe': Color(0xFFFF4757),
    'Aerobico': Color(0xFFFFB020),
  };

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final volt = isDark ? _voltDark : _voltLight;

    final scheme = ColorScheme.fromSeed(seedColor: volt, brightness: brightness).copyWith(
      primary: volt,
      onPrimary: _ink,
      secondary: _secondary,
      onSecondary: Colors.white,
      tertiary: _tertiary,
      onTertiary: _ink,
      error: _error,
      onError: Colors.white,
      surface: isDark ? _surfaceDark : _surfaceLight,
      onSurface: isDark ? _textDark : _textLight,
      onSurfaceVariant: isDark ? _textDark2 : _textLight2,
      outlineVariant: isDark ? _lineDark : _lineLight,
    );

    final baseText = ThemeData(brightness: brightness).textTheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? _bgDark : _bgLight,
      dividerColor: isDark ? _lineDark : _lineLight,
      textTheme: _voltTextTheme(baseText),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? _appBarDark : _appBarLight,
        foregroundColor: _appBarText,
        centerTitle: false,
        elevation: 0,
        titleTextStyle: GoogleFonts.archivo(
          color: _appBarText,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: volt,
        foregroundColor: _ink,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: volt.withValues(alpha: isDark ? 0.30 : 0.28),
        elevation: 3,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: volt.withValues(alpha: isDark ? 0.30 : 0.28),
      ),
      chipTheme: const ChipThemeData(side: BorderSide.none),
      inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  /// Archivo for display/headline/title/button; Hanken Grotesk for body & labels.
  static TextTheme _voltTextTheme(TextTheme base) {
    TextStyle? display(TextStyle? s, {FontWeight weight = FontWeight.w800, double spacing = -0.5}) =>
        GoogleFonts.archivo(textStyle: s, fontWeight: weight, letterSpacing: spacing);
    TextStyle? body(TextStyle? s) => GoogleFonts.hankenGrotesk(textStyle: s);

    return base.copyWith(
      displayLarge: display(base.displayLarge),
      displayMedium: display(base.displayMedium),
      displaySmall: display(base.displaySmall),
      headlineLarge: display(base.headlineLarge),
      headlineMedium: display(base.headlineMedium),
      headlineSmall: display(base.headlineSmall, weight: FontWeight.w700, spacing: -0.3),
      titleLarge: display(base.titleLarge, weight: FontWeight.w700, spacing: -0.2),
      titleMedium: body(base.titleMedium)?.copyWith(fontWeight: FontWeight.w600),
      titleSmall: body(base.titleSmall)?.copyWith(fontWeight: FontWeight.w600),
      bodyLarge: body(base.bodyLarge),
      bodyMedium: body(base.bodyMedium),
      bodySmall: body(base.bodySmall),
      labelLarge: display(base.labelLarge, weight: FontWeight.w700, spacing: 0.4),
      labelMedium: body(base.labelMedium),
      labelSmall: body(base.labelSmall),
    );
  }
}
