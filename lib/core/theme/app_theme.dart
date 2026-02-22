import 'package:flutter/material.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Theme extension defining colors for prayer status chips.
///
/// Provides foreground and background colors for complete, partial,
/// and missed prayer states in both light and dark themes.
@immutable
class StatusChipTheme extends ThemeExtension<StatusChipTheme> {
  const StatusChipTheme({
    required this.completeBackground,
    required this.completeForeground,
    required this.partialBackground,
    required this.partialForeground,
    required this.missedBackground,
    required this.missedForeground,
  });

  final Color completeBackground;
  final Color completeForeground;
  final Color partialBackground;
  final Color partialForeground;
  final Color missedBackground;
  final Color missedForeground;

  @override
  StatusChipTheme copyWith({
    Color? completeBackground,
    Color? completeForeground,
    Color? partialBackground,
    Color? partialForeground,
    Color? missedBackground,
    Color? missedForeground,
  }) {
    return StatusChipTheme(
      completeBackground: completeBackground ?? this.completeBackground,
      completeForeground: completeForeground ?? this.completeForeground,
      partialBackground: partialBackground ?? this.partialBackground,
      partialForeground: partialForeground ?? this.partialForeground,
      missedBackground: missedBackground ?? this.missedBackground,
      missedForeground: missedForeground ?? this.missedForeground,
    );
  }

  @override
  StatusChipTheme lerp(ThemeExtension<StatusChipTheme>? other, double t) {
    if (other is! StatusChipTheme) {
      return this;
    }
    return StatusChipTheme(
      completeBackground:
          Color.lerp(
            completeBackground,
            other.completeBackground,
            t,
          ) ??
          completeBackground,
      completeForeground:
          Color.lerp(
            completeForeground,
            other.completeForeground,
            t,
          ) ??
          completeForeground,
      partialBackground:
          Color.lerp(
            partialBackground,
            other.partialBackground,
            t,
          ) ??
          partialBackground,
      partialForeground:
          Color.lerp(
            partialForeground,
            other.partialForeground,
            t,
          ) ??
          partialForeground,
      missedBackground:
          Color.lerp(
            missedBackground,
            other.missedBackground,
            t,
          ) ??
          missedBackground,
      missedForeground:
          Color.lerp(
            missedForeground,
            other.missedForeground,
            t,
          ) ??
          missedForeground,
    );
  }
}

/// Application theme configuration following Material Design 3.
///
/// Provides light and dark themes with custom color schemes,
/// the Cairo font family, and status chip theme extension.
class AppTheme {
  static const _fontFamily = 'Cairo';
  static const _lightBackground = Color(0xFFECFEFF);
  static const _darkBackground = Color(0xFF0B2530);
  static const _lightSurface = Color(0xFFFFFFFF);
  static const _darkSurface = Color(0xFF102A36);
  static const _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0891B2),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFCFFAFE),
    onPrimaryContainer: Color(0xFF0E7490),
    secondary: Color(0xFF22D3EE),
    onSecondary: Color(0xFF083344),
    secondaryContainer: Color(0xFFA5F3FC),
    onSecondaryContainer: Color(0xFF164E63),
    tertiary: Color(0xFF059669),
    onTertiary: Color(0xFFFFFFFF),
    error: Color(0xFFB91C1C),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: Color(0xFF7F1D1D),
    surface: _lightSurface,
    onSurface: Color(0xFF164E63),
    surfaceContainerHighest: Color(0xFFE0F2FE),
    onSurfaceVariant: Color(0xFF155E75),
    outline: Color(0xFF7DD3FC),
    outlineVariant: Color(0xFFBAE6FD),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF0B2530),
    onInverseSurface: Color(0xFFECFEFF),
    inversePrimary: Color(0xFF22D3EE),
    surfaceTint: Color(0xFF0891B2),
  );
  static const _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF22D3EE),
    onPrimary: Color(0xFF083344),
    primaryContainer: Color(0xFF0E7490),
    onPrimaryContainer: Color(0xFFCFFAFE),
    secondary: Color(0xFF0891B2),
    onSecondary: Color(0xFFECFEFF),
    secondaryContainer: Color(0xFF155E75),
    onSecondaryContainer: Color(0xFFECFEFF),
    tertiary: Color(0xFF10B981),
    onTertiary: Color(0xFF052E16),
    error: Color(0xFFFCA5A5),
    onError: Color(0xFF7F1D1D),
    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: Color(0xFFFEE2E2),
    surface: _darkSurface,
    onSurface: Color(0xFFECFEFF),
    surfaceContainerHighest: Color(0xFF123544),
    onSurfaceVariant: Color(0xFFBFE8F2),
    outline: Color(0xFF2C6475),
    outlineVariant: Color(0xFF1B4B5B),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFECFEFF),
    onInverseSurface: Color(0xFF0B2530),
    inversePrimary: Color(0xFF0891B2),
    surfaceTint: Color(0xFF22D3EE),
  );

  static ThemeData light({ColorScheme? dynamicScheme}) {
    return _theme(dynamicScheme ?? _lightScheme, _lightBackground);
  }

  static ThemeData dark({ColorScheme? dynamicScheme}) {
    return _theme(dynamicScheme ?? _darkScheme, _darkBackground);
  }

  static ThemeData _theme(ColorScheme colorScheme, Color backgroundColor) {
    final textTheme = _textTheme(colorScheme);
    final statusChipTheme = _statusChipTheme(colorScheme.brightness);
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: _fontFamily,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colorScheme.onSurfaceVariant,
        textColor: colorScheme.onSurface,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primaryContainer,
        labelStyle: textTheme.labelMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: colorScheme.onSecondaryContainer,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: AppSpacing.xs,
        ),
        shape: const StadiumBorder(),
      ),
      extensions: [statusChipTheme],
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static TextTheme _textTheme(ColorScheme colorScheme) {
    return TextTheme(
      displaySmall: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      headlineLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: colorScheme.onSurfaceVariant,
      ),
      labelLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      labelMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  static StatusChipTheme _statusChipTheme(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const StatusChipTheme(
        completeBackground: Color(0xFF14532D),
        completeForeground: Color(0xFFDCFCE7),
        partialBackground: Color(0xFF713F12),
        partialForeground: Color(0xFFFEF9C3),
        missedBackground: Color(0xFF7F1D1D),
        missedForeground: Color(0xFFFEE2E2),
      );
    }
    return const StatusChipTheme(
      completeBackground: Color(0xFFDCFCE7),
      completeForeground: Color(0xFF166534),
      partialBackground: Color(0xFFFEF9C3),
      partialForeground: Color(0xFF854D0E),
      missedBackground: Color(0xFFFEE2E2),
      missedForeground: Color(0xFF7F1D1D),
    );
  }
}
