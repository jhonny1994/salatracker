/// Design system constants following Material 3 and mobile-design
/// best practices
library;

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// SPACING (using 4px base unit, Material 3 aligned)
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class AppSpacing {
  /// 4px - Micro spacing
  static const double xs = 4;

  /// 8px - Compact spacing
  static const double sm = 8;

  /// 12px - Small spacing
  static const double md = 12;

  /// 16px - Base spacing unit
  static const double lg = 16;

  /// 20px - Medium spacing
  static const double xl = 20;

  /// 24px - Large spacing
  static const double xxl = 24;

  /// 32px - Extra large spacing
  static const double xxxl = 32;
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// TOUCH TARGETS (mobile-design: min 44pt iOS / 48dp Android)
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class AppTouchTargets {
  /// Minimum touch target size (48px per Android Material 3)
  static const double minimum = 48;

  /// Comfortable touch target for primary actions
  static const double comfortable = 56;

  /// Large touch target for critical actions
  static const double large = 64;

  /// Checkbox/radio size (44px per iOS HIG)
  static const double checkbox = 44;
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// BORDER RADIUS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class AppRadius {
  /// 4px - Minimal rounding
  static const double xs = 4;

  /// 8px - Small rounding
  static const double sm = 8;

  /// 12px - Medium rounding
  static const double md = 12;

  /// 16px - Base card radius (Material 3)
  static const double lg = 16;

  /// 20px - Large rounding (chips, badges)
  static const double xl = 20;

  /// 28px - Extra large (bottom sheets)
  static const double xxl = 28;
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ANIMATION DURATIONS (mobile-design: 150-300ms for micro-animations)
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class AppDurations {
  /// 150ms - Fast micro-animations
  static const Duration fast = Duration(milliseconds: 150);

  /// 200ms - Default UI transitions
  static const Duration normal = Duration(milliseconds: 200);

  /// 300ms - Smooth transitions
  static const Duration smooth = Duration(milliseconds: 300);

  /// 500ms - Deliberate animations
  static const Duration slow = Duration(milliseconds: 500);

  /// 800ms - Progress indicators
  static const Duration progress = Duration(milliseconds: 800);
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ICON SIZES
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class AppIconSizes {
  /// 16px - Small inline icons
  static const double xs = 16;

  /// 18px - Compact icons
  static const double sm = 18;

  /// 20px - Default icon size
  static const double md = 20;

  /// 24px - Standard icon size (Material 3)
  static const double lg = 24;

  /// 28px - Large icons
  static const double xl = 28;

  /// 64px - Hero icons
  static const double hero = 64;
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ELEVATIONS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class AppElevations {
  static const double none = 0;
  static const double low = 1;
  static const double medium = 3;
  static const double high = 6;
}
