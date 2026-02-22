# UI Re-Art Plan - Product-Grade Minimalist Experience

> **Part of:** [Documentation Ecosystem](README.md) | **Aligned with:** [design-system.md](design-system.md), [ux-gamification-psychology.md](ux-gamification-psychology.md), [tasks.md](tasks.md)

## Goal
Create a unified, non-gimmicky, non-generic mobile UI that feels handcrafted, calm, and trustworthy while preserving performance, accessibility, RTL-first behavior, and localization quality.

This re-art is not cosmetic repainting. It is a full UX ecosystem pass across all user-facing components.

## Design Direction (Locked)
- Minimalist, high-clarity layouts with strong spacing rhythm.
- Calm visual hierarchy: completion first, streak second, points optional.
- Reflective motivation, never pressure-based or celebratory excess.
- One visual grammar across all screens: same card geometry, icon language, spacing cadence, and motion curve family.
- Arabic-first layout behavior with equal quality in EN/FR.

## Product Psychology Guardrails
- No guilt loops, no urgency loops, no failure framing.
- Status is informative, not judgmental.
- Reward moments are subtle and respectful.
- Notifications and prompts remain supportive and consent-based.

## Ecosystem Inventory (Must Be Covered)

### Today
- `lib/features/today/presentation/today_screen.dart`
- `lib/features/today/presentation/widgets/today_progress_card.dart`
- `lib/features/today/presentation/widgets/prayer_list_item.dart`
- `lib/features/today/presentation/widgets/today_streak_card.dart`
- `lib/features/today/presentation/widgets/today_celebration_card.dart`
- `lib/features/today/presentation/widgets/today_loading_state.dart`
- `lib/features/today/presentation/widgets/today_error_state.dart`

### Calendar
- `lib/features/calendar/presentation/calendar_screen.dart`
- `lib/features/calendar/presentation/widgets/calendar_view.dart`
- `lib/features/calendar/presentation/widgets/calendar_day_cell.dart`
- `lib/features/calendar/presentation/widgets/calendar_day_detail.dart`
- `lib/features/calendar/presentation/widgets/calendar_stat_item.dart`
- `lib/features/calendar/presentation/widgets/calendar_loading_state.dart`
- `lib/features/calendar/presentation/widgets/calendar_error_state.dart`

### Settings
- `lib/features/settings/presentation/settings_screen.dart`
- `lib/features/settings/presentation/prayer_schedule_screen.dart`
- `lib/features/settings/presentation/widgets/settings_tile.dart`
- `lib/features/settings/presentation/widgets/settings_switch_tile.dart`
- `lib/features/settings/presentation/widgets/offset_picker_dialog.dart`
- `lib/features/settings/presentation/widgets/settings_error_state.dart`

### Onboarding
- `lib/features/onboarding/presentation/onboarding_screen.dart`
- `lib/features/onboarding/presentation/widgets/welcome_page.dart`
- `lib/features/onboarding/presentation/widgets/prayer_times_page.dart`
- `lib/features/onboarding/presentation/widgets/notifications_page.dart`
- `lib/features/onboarding/presentation/widgets/app_lock_page.dart`
- `lib/features/onboarding/presentation/widgets/confirmation_page.dart`

### Security and Badges
- `lib/features/security/presentation/pages/app_lock_screen.dart`
- `lib/features/security/presentation/widgets/pin_pad.dart`
- `lib/features/security/presentation/widgets/pin_setup_dialog.dart`
- `lib/features/security/presentation/widgets/current_pin_dialog.dart`
- `lib/features/badges/presentation/badges_screen.dart`
- `lib/features/badges/presentation/widgets/badge_tile.dart`

### Cross-App Navigation and Theming
- `lib/core/router/root_shell.dart`
- `lib/core/theme/app_theme.dart`

## Re-Art Architecture

### 1) Shared Visual Primitives
Introduce a small set of reusable, opinionated primitives to reduce UI drift:
- `AppSectionHeader`
- `AppSurfaceCard`
- `AppMetricTile`
- `AppEmptyState`
- `AppInlineNotice`

All current feature widgets must consume these primitives where applicable.

### 2) Token Strictness
- Keep current palette family, but tighten usage rules (primary/secondary/surface assignments).
- Remove ad-hoc spacing/layout patterns and map to spacing tokens only.
- Ensure consistent border-radius and elevation levels per component class.

### 3) Motion Unification
- One motion spec across app:
  - Entry: 200-240ms, easeOut
  - Toggle feedback: 140-180ms
  - State transitions: 220-280ms
- Keep celebration motion subtle and finite (no infinite attention-stealing loops).

### 4) Typographic Rhythm
- Preserve Cairo.
- Standardize title/body/label pairings by component type.
- Avoid ad-hoc fontWeight overrides except where defined by component spec.

## Screen-by-Screen Re-Art Plan

### Today (Primary Product Surface)
- Redesign as a cohesive narrative stack: progress hero -> prayer flow -> contextual encouragement.
- Make prayer list cards cleaner and calmer with stronger action affordance.
- Keep metric hierarchy explicit and stable across day states.

### Calendar
- Increase legibility of month state at a glance without adding visual noise.
- Make day detail stats and prayer rows visually aligned with Today cards.
- Improve state communication with text + icon + color, not color alone.

### Settings
- Normalize sections into same card rhythm and spacing cadence.
- Improve scanability of toggles and destructive/sensitive actions (PIN reset).
- Keep settings dense but never crowded.

### Onboarding
- Move from repeated template cards to progressive narrative flow.
- Add consistent step identity and clear forward momentum.
- Keep permission asks contextual and low pressure.

### Security and Badges
- Security screens: trust-first visuals, minimal ornament, explicit clarity.
- Badges: reflective timeline/list with soft hierarchy, no gamified pressure cues.

## Accessibility and Localization Requirements
- 44/48+ touch targets on all interactives.
- Contrast validated in both themes for all text tiers.
- Full RTL mirror checks for all directional icons and spacing.
- Localization completeness across EN/AR/FR for all new/changed UI strings.
- Avoid numeric/date formatting that breaks locale expectations.

## Delivery Phases

### Phase A - Foundation Pass
- Add shared primitives and token usage guards.
- Refactor core reusable widgets (`settings_tile`, `settings_switch_tile`, stat widgets).

### Phase B - Core Surfaces
- Re-art Today and Calendar end-to-end.

### Phase C - Configuration and Trust
- Re-art Settings + Security.

### Phase D - First-Run Experience
- Re-art Onboarding and final confirmation.

### Phase E - Polish and QA
- Motion parity, RTL parity, accessibility sweep, localization sweep.

## Acceptance Criteria
- All listed UI components updated and visually consistent.
- No isolated legacy UI islands left.
- `flutter analyze` clean, tests passing.
- New UI remains fast and readable on mid-range devices.
- UX tone fully aligned with `ux-gamification-psychology.md`.

## Non-Goals
- No flashy visual gimmicks.
- No dark-mode-only aesthetic bias.
- No gameplay mechanics beyond reflective progress model.
