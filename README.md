# Salat Tracker (سجل الصلاة)

Enterprise-grade, offline-first Flutter app for tracking the five daily prayers with calm, respectful gamification.

## Product Summary
- Android-first, iOS-ready
- Arabic-first (RTL) with English fallback
- Offline-first data storage and future-ready repository layer
- Supportive reminders and progress-first gamification

## Engineering Standards
- Flutter + Riverpod + Freezed
- Feature-first structure with clean boundaries
- Material 3 with light/dark parity
- Sentry configured via env
- Cairo font bundled locally

## Project Structure
```
lib/
  core/            # theme, routing, localization, utils
  features/        # today, calendar, settings (feature-first)
  shared/          # shared widgets and helpers
```

## Setup
1) Install Flutter, run `flutter doctor`
2) Copy `.env.example` to `.env` and set `SENTRY_DSN`
3) `flutter pub get`
4) `flutter run`

## Configuration
- Package ID: `com.carbodex.salat_tracker`
- Version: `0.1.0+1`
- Android minSdk: `23`
- Display names: AR "سجل الصلاة", EN "Salat Tracker" (others default to EN)

## Documentation
- `docs/plan.md`
- `docs/prd.md`
- `docs/tasks.md`
- `docs/design-system.md`
- `docs/ux-gamification-psychology.md`
