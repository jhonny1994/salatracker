# Project Plan - سجل الصلاة

## Overview
Offline-first Flutter app to gamify daily prayer completion with streaks, points, calendar history, and reminders. Arabic-first (RTL) with Cairo font and English fallback for all other locales. Android-first, iOS-ready.

## Decisions Locked
- App name: سجل الصلاة
- App display names: AR "سجل الصلاة", EN "Salat Tracker" (fallback for all others)
- Prayer names: AR "الفجر، الظهر، العصر، المغرب، العشاء"; EN "Fajr, Dhuhr, Asr, Maghrib, Isha"
- Default locale: Arabic (RTL), English fallback for all other locales; UI strings localized in ar/en/fr
- Font: Cairo bundled locally
- Architecture: feature-first + clean layers
- State/models: Riverpod + Freezed
- Storage: Hive CE (no encryption at rest for v1)
- Notifications: per-prayer offsets + end-of-day reminder (Isha + 2 hours default)
- App lock: biometrics + PIN fallback; trigger after device screen off/lock (Android exact, iOS best-effort)
- Analytics/crash: Sentry (free tier)
- CI/CD: signed APK + signed AAB via GitHub Actions
- Locale names: derived from supportedLocales + locale_names
- Navigation: bottom NavigationBar with Today, Calendar, Settings
- Gamification hierarchy: completion percentage primary, streak secondary; reflective badges only
- Metrics: daily and rolling percentage visible; streaks de-emphasized
- Notifications: opt-in during onboarding, supportive tone (no shame language)
- Points: transparent formula, optional display (+10 per prayer, +5 daily, +50 monthly 90%+)
- Badges: First Prayer Logged, Week of Consistency (7 days), Month Complete (90%+), Season Champion (3 months 80%+)
- Time formatting: follow device locale (12/24), no manual override in v1
- Theme: light/dark parity with system default (no dark-mode bias)
- Package ID: com.carbodex.salat_tracker
- Android minSdk: 23
- Version: 0.1.0+1
- Sentry: DSN via env, using a runtime env loader (flutter_dotenv)

## Phase 1: Foundations
- Create Flutter project and feature-first structure
- Add Riverpod + Freezed + build_runner + very_good_analysis
- Add localization pipeline (flutter_intl + intl_utils + Localizely)
- Bundle Cairo font assets and set as default
- Set up routing (go_router) and theme (light/dark/system persisted)

## Phase 2: Data and Domain
- Define domain models (PrayerDay, PrayerEntry, Settings)
- Implement Hive CE adapters and boxes
- Repository interfaces for future backend swap
- Implement streak and points logic with full-day completion rule

## Phase 3: Core UX
- Today screen: checklist + progress (percentage primary) + quick log + supportive summary
- Calendar view: month grid with day status colors
- Day detail + history editing with streak impact message
- Settings: prayer times, offsets, language, theme, notifications, haptics
- Add badges view (reflective, no push)

## Phase 4: Notifications
- Schedule 5 daily reminders with per-prayer offsets
- End-of-day reminder at Isha + 2 hours (editable)
- Handle permissions (Android 13+), timezone/DST rescheduling
- Ensure notification tap deep-links to relevant prayer

## Phase 5: App Lock
- Onboarding prompt to enable/disable App Lock
- Lock triggered only after device screen off/lock
- Biometrics with PIN fallback
- Best-effort iOS implementation and documented behavior

## Phase 6: Quality and Release
- Unit tests for streaks, points, data integrity
- Notification scheduling tests
- RTL layout checks and smoke tests
- Supportive copy review (no shame language)
- Sentry integration with PII scrubbing
- GitHub Actions builds signed APK + signed AAB
- Play Store readiness checklist and release notes
- Brand assets prep before production push (icon, splash, store media)
- Follow UX/gamification/psychology guide: docs/ux-gamification-psychology.md
