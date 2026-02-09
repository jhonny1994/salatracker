# Salat Tracker - سجل الصلاة

Track the five daily prayers with a calm, respectful, offline-first experience designed for consistency, reflection, and privacy.

Salat Tracker is an Arabic-first Flutter app (with EN/FR support) that helps users log prayers, review progress over time, and receive supportive reminders without pressure mechanics.

## Why This Product
- **Progress-first motivation:** completion percentage is primary, streaks are secondary.
- **Respectful tone:** no shame-based copy, no manipulative loops.
- **Offline-first reliability:** core experience works without network.
- **Privacy-minded:** local data storage with app lock support in progress.

## Core Experience
- **Today:** one-tap checklist for the five prayers, progress ring, streak, optional points.
- **Calendar:** month overview with day states and day-level history editing.
- **Settings:** prayer schedule, reminder offsets, language, theme, haptics, points visibility, week start.
- **Onboarding:** first-run setup for prayer times, reminder opt-in, and app personalization.

## Current Build Status
- **Implemented and usable:** foundations, data layer, Today/Calendar/Settings UX, onboarding baseline, notification scheduling.
- **In progress toward production:** notification hardening, reflective badges, app lock security hardening, full test and release automation.
- **Execution source of truth:** `docs/tasks.md` and `docs/plan.md`.

## Product Principles
- **Arabic-first, RTL-correct** with Cairo typography.
- **Light/dark parity** with Material 3 design tokens.
- **Reflective gamification** (no leaderboards, no shame language).
- **Business-grade quality target** with explicit go/no-go criteria.

## Tech Stack
- Flutter (Material 3)
- Riverpod 3 + riverpod_generator
- Freezed + JSON serialization
- Hive CE for local persistence
- go_router for navigation
- flutter_local_notifications + timezone for reminders
- sentry_flutter for crash reporting and analytics breadcrumbs

## Quick Start
1. Install Flutter SDK and verify with `flutter doctor`.
2. Create local env file: copy `.env.example` to `.env`.
3. Set environment values:
   - `SENTRY_DSN`
   - `SENTRY_ENV`
4. Install dependencies: `flutter pub get`.
5. Run app: `flutter run`.

## Configuration
- Package ID: `com.carbodex.salat_tracker`
- Version: `0.1.0+1`
- Android minSdk: `23`
- Locales: Arabic, English, French
- Font: Cairo (bundled)

## Repository Structure
```text
lib/
  core/        # routing, theme, localization, notifications, storage
  features/    # today, calendar, settings, onboarding, prayer, security
  shared/      # shared constants and extensions
docs/          # PRD, plan, tasks, design, rules, UX guidance
```

## Documentation Hub
- Product requirements: `docs/prd.md`
- Delivery plan: `docs/plan.md`
- Execution checklist: `docs/tasks.md`
- Engineering rules: `docs/rules.md`
- Design system: `docs/design-system.md`
- UX and gamification: `docs/ux-gamification-psychology.md`

## Road to v1.0.0
- Finish reflective badges (domain + UI + localization + tests).
- Complete app lock hardening (screen-off policy, hashing, lifecycle tests).
- Expand test coverage and enforce CI quality gates.
- Finalize signed release pipelines and store-readiness assets.

## License
Proprietary/internal project unless otherwise specified by repository owner.
