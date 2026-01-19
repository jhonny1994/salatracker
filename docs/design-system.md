# Design System - سجل الصلاة

## Purpose
Define the visual and interaction system for سجل الصلاة with a calm, respectful, Arabic-first experience. This system aligns with Flutter Material 3 while preserving the locked Cairo font and RTL defaults.

## Product Tone
- Calm, respectful, gentle motivation
- Offline-first, low-friction daily use
- Arabic-first with RTL layout

## Typography
- **Primary font:** Cairo (bundled locally)
- **Weights:** 400 (body), 500 (emphasis), 700 (headings)
- **Line height:** 1.5-1.7 for body text
- **RTL:** Align primary text and actions to start edge

## Color Palette
| Role | Hex | Usage |
| --- | --- | --- |
| Primary | #0891B2 | Primary actions, progress, highlights |
| Secondary | #22D3EE | Accents, secondary UI elements |
| CTA | #059669 | Confirm/save actions |
| Background | #ECFEFF | App background |
| Text | #164E63 | Primary text |
| Surface | #FFFFFF | Cards and panels |
| Error | #B91C1C | Validation and error states |
| Warning | #F59E0B | Partial/attention states |

## Material 3 Alignment
- **Theme:** `ThemeData(useMaterial3: true)`
- **Color scheme:** Map palette to `ColorScheme` fields
- **Components:** Prefer M3 widgets (Card, ListTile, FilledButton, SegmentedButton)
- **Shapes:** Rounded 12-16 for cards and inputs
- **Elevation:** Soft shadows, low contrast, consistent levels
- **Light/dark parity:** Design and QA both themes equally; no dark-mode bias

## Material 3 Token Map (Light)
Use these as the default `ColorScheme` values.

| ColorScheme Field | Hex | Notes |
| --- | --- | --- |
| primary | #0891B2 | Primary actions, progress |
| onPrimary | #FFFFFF | Text/icons on primary |
| primaryContainer | #CFFAFE | Soft highlight backgrounds |
| onPrimaryContainer | #0E7490 | Text on primary containers |
| secondary | #22D3EE | Accents and secondary controls |
| onSecondary | #083344 | Text/icons on secondary |
| secondaryContainer | #A5F3FC | Soft secondary background |
| onSecondaryContainer | #164E63 | Text on secondary containers |
| tertiary | #059669 | Confirm/save actions |
| onTertiary | #FFFFFF | Text/icons on tertiary |
| background | #ECFEFF | App background |
| onBackground | #164E63 | Primary text |
| surface | #FFFFFF | Cards and panels |
| onSurface | #164E63 | Text on surface |
| surfaceVariant | #E0F2FE | Subtle panels and chips |
| onSurfaceVariant | #155E75 | Text on surface variant |
| outline | #7DD3FC | Dividers and outlines |
| outlineVariant | #BAE6FD | Subtle borders |
| error | #B91C1C | Errors |
| onError | #FFFFFF | Text/icons on error |
| errorContainer | #FEE2E2 | Error container |
| onErrorContainer | #7F1D1D | Text on error container |

## Material 3 Token Map (Dark)
Use these for dark mode. Keep contrast high for Arabic text.

| ColorScheme Field | Hex | Notes |
| --- | --- | --- |
| primary | #22D3EE | Primary actions, progress |
| onPrimary | #083344 | Text/icons on primary |
| primaryContainer | #0E7490 | Soft highlight backgrounds |
| onPrimaryContainer | #CFFAFE | Text on primary containers |
| secondary | #0891B2 | Accents and secondary controls |
| onSecondary | #E0F2FE | Text/icons on secondary |
| secondaryContainer | #155E75 | Soft secondary background |
| onSecondaryContainer | #ECFEFF | Text on secondary containers |
| tertiary | #10B981 | Confirm/save actions |
| onTertiary | #052E16 | Text/icons on tertiary |
| background | #0B2530 | App background |
| onBackground | #ECFEFF | Primary text |
| surface | #102A36 | Cards and panels |
| onSurface | #ECFEFF | Text on surface |
| surfaceVariant | #123544 | Subtle panels and chips |
| onSurfaceVariant | #BFE8F2 | Text on surface variant |
| outline | #2C6475 | Dividers and outlines |
| outlineVariant | #1B4B5B | Subtle borders |
| error | #FCA5A5 | Errors |
| onError | #7F1D1D | Text/icons on error |
| errorContainer | #7F1D1D | Error container |
| onErrorContainer | #FEE2E2 | Text on error container |

## Material 3 Typography Scale
Use Cairo with these sizes to keep hierarchy consistent.

| Role | Size | Weight | Notes |
| --- | --- | --- | --- |
| displaySmall | 36 | 700 | Rare, only for hero stats |
| headlineLarge | 28 | 700 | Screen titles |
| headlineMedium | 24 | 700 | Section titles |
| titleLarge | 20 | 600 | Card titles |
| titleMedium | 18 | 600 | List titles |
| bodyLarge | 16 | 400 | Default body |
| bodyMedium | 14 | 400 | Secondary body |
| labelLarge | 14 | 600 | Buttons |
| labelMedium | 12 | 600 | Chips and small labels |

## Component Usage Guide
- **Buttons:** Use FilledButton for primary actions, OutlinedButton for secondary, TextButton for tertiary.
- **List rows:** Use ListTile with compact density; avoid custom rows unless needed.
- **Cards:** Use Card with medium elevation and 12-16 radius.
- **Inputs:** Use TextField with clear labels and helper text.
- **Chips:** Use FilterChip or AssistChip for status and small controls.
- **Progress:** Use LinearProgressIndicator for subtle progress, CircularProgressIndicator for short waits.
- **Navigation:** Use NavigationBar (Material 3) for bottom nav (Today, Calendar, Settings).
- **Dialogs:** Use AlertDialog for confirmations and edits.

## Flutter ThemeData Example
Use as a baseline in your app theme configuration.

```dart
final lightColorScheme = const ColorScheme(
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
  background: Color(0xFFECFEFF),
  onBackground: Color(0xFF164E63),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF164E63),
  surfaceVariant: Color(0xFFE0F2FE),
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

final darkColorScheme = const ColorScheme(
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
  background: Color(0xFF0B2530),
  onBackground: Color(0xFFECFEFF),
  surface: Color(0xFF102A36),
  onSurface: Color(0xFFECFEFF),
  surfaceVariant: Color(0xFF123544),
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

final textTheme = const TextTheme(
  displaySmall: TextStyle(fontFamily: 'Cairo', fontSize: 36, fontWeight: FontWeight.w700),
  headlineLarge: TextStyle(fontFamily: 'Cairo', fontSize: 28, fontWeight: FontWeight.w700),
  headlineMedium: TextStyle(fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.w700),
  titleLarge: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.w600),
  titleMedium: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w600),
  bodyLarge: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
  bodyMedium: TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w400, height: 1.5),
  labelLarge: TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w600),
  labelMedium: TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.w600),
);

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: textTheme,
  cardTheme: const CardTheme(elevation: 1.5, margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12)),
  snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
  visualDensity: VisualDensity.standard,
);
```

## UI QA Checklist
- **Theme consistency:** All screens use Material 3 components and tokens.
- **Typography:** Cairo applied across all text styles.
- **RTL:** All primary actions align with RTL start edge.
- **Contrast:** Text contrast meets 4.5:1 for body text.
- **Touch:** All interactive targets are at least 44x44.
- **States:** Completed, partial, not logged states are labeled.
- **Motion:** Animations respect reduced-motion preferences.
- **Navigation:** Bottom nav uses NavigationBar and consistent labels.

## Layout and Spacing
- **Grid:** 8px spacing system
- **Touch targets:** Minimum 44x44
- **Padding:** 16-20 horizontal for primary screens
- **Line length:** 60-70 characters max for longer text blocks

## Core Components
- **Prayer checklist card:** Name, time, toggle, status chip
- **Progress indicator:** Ring or linear bar for daily completion
- **Status chip:** Complete/Partial/Not logged with text label + color
- **Day cell:** Calendar status indicator with accessible label
- **Settings row:** Title, description, trailing control

## Interaction and Feedback
- One-tap logging with immediate state change
- Optional light haptic on completion (avoid overuse)
- Undo via snackbar for mistakes
- Clear confirmation when edits affect streaks
- Supportive copy tone (no shame language; progress-forward phrasing)
- Metric hierarchy: show completion percentage first, streak secondary

## Accessibility
- Contrast ratio 4.5:1 minimum for text
- Visible focus states for keyboard navigation
- Avoid color-only status indication; use labels or icons
- Respect reduced motion preferences

## RTL and Localization
- RTL is default for Arabic
- Mirror icons and progress direction for RTL
- Use localized language names via locale_names

## Motion
- 150-300ms transitions for subtle feedback
- Use opacity and transform (avoid layout shifts)
- Avoid busy animations in core flows

## Anti-Patterns to Avoid
- Emoji icons (use SVG or Material icons)
- Generic template layouts
- Low-contrast text or surfaces
- Overly gamified visuals

## Screen-Level Guidelines
- **Today:** Checklist, progress (primary), streak (secondary), points (optional), quick actions
- **Calendar:** Month grid, status legend, day detail entry
- **Settings:** Clear sections and compact controls (include haptics toggle)
- **Onboarding:** Short, opt-in notifications, focuses on times + reminders
- **Badges:** Reflective milestones shown in a calm list (no push prompts)

## Component Specs
### Prayer Checklist Card
- **Layout:** Title (prayer name), time, status chip, trailing toggle
- **States:** default, completed, not logged
- **Interactions:** tap row or toggle to change state; show snackbar undo

### Status Chip
- **Complete (light):** background #DCFCE7, text #166534
- **Partial (light):** background #FEF9C3, text #854D0E
- **Not logged (light):** background #FEE2E2, text #7F1D1D
- **Complete (dark):** background #14532D, text #DCFCE7
- **Partial (dark):** background #713F12, text #FEF9C3
- **Not logged (dark):** background #7F1D1D, text #FEE2E2
- **Always include text label, not color-only**

### Progress Summary
- **Primary metric:** completion percentage
- **Secondary metric:** streak count (subdued style)
- **Tone:** supportive phrasing, no shame language

### Progress Summary
- **Primary:** Circular progress with percent label
- **Secondary:** Linear progress in list header
- **Text:** short label like "Today's progress"

### Calendar Day Cell
- **States:** complete/partial/not logged/empty
- **Indicator:** filled dot or small ring + label in day detail
- **Tap target:** full cell (min 44x44)

### Settings Row
- **Layout:** Title, optional description, trailing control
- **Controls:** Switch, time picker, segmented button
- **Density:** compact but readable for RTL

## Motion Guidance
- **Page enter:** 200-250ms fade + slide (8-12dp)
- **Checklist toggle:** 150-200ms color/opacity transition
- **Progress change:** animate value over 250ms
- **Reduced motion:** disable or shorten to 100ms
