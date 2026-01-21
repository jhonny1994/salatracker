# Product Requirements Document - سجل الصلاة

> **Part of:** [Documentation Ecosystem](README.md) | **Related:** [plan.md](plan.md), [ux-gamification-psychology.md](ux-gamification-psychology.md)

## Summary
سجل الصلاة is an offline-first prayer tracking app that gamifies daily commitment to the five prayers. It provides streaks, points, reminders, and a calendar history. The app is Arabic-first (RTL) with English fallback and French UI strings, designed with a calm, respectful UI.

## App Identity
- Package ID: com.carbodex.salat_tracker
- Display names: AR "سجل الصلاة", EN "Salat Tracker" (fallback for all others)
- Prayer names: AR "الفجر، الظهر، العصر، المغرب، العشاء"; EN "Fajr, Dhuhr, Asr, Maghrib, Isha"

## Goals
- Increase daily prayer completion consistency
- Provide gentle reminders and accountability
- Work fully offline without network dependency
- Deliver Arabic-first, culturally appropriate UX

## Non-Goals (v1)
- No backend sync
- No automatic prayer time calculation
- No social/leaderboards

## Target Users
- Arabic-speaking Muslims seeking a simple daily prayer tracker

## User Stories
- As a user, I can set fixed prayer times and log each prayer.
- As a user, I can see streaks and points for motivation.
- As a user, I can edit past days if I forgot to log.
- As a user, I can view a calendar of completion status.
- As a user, I can receive reminders and an end-of-day summary.
- As a user, I can protect access using biometrics or PIN.

## Functional Requirements
- Daily log for 5 prayers (fixed times)
- Completion percentage is the primary metric; streak shown as secondary
- Streak increments only on fully completed days
- Points awarded per prayer and per completed day (transparent formula)
- Optional points display (hideable in settings)
- Calendar month view with status (complete/partial/not logged)
- History editing with streak recalculation
- Notifications with per-prayer offsets
- End-of-day reminder default Isha + 2 hours (editable)
- Notifications are opt-in during onboarding; tone is supportive, no shame language
- App Lock enabled via onboarding, biometrics + PIN fallback
- Language list read from supportedLocales
- Localized language names via locale_names
- Theme light/dark/system persisted with light/dark parity (no dark-mode bias)
- Bottom NavigationBar (Material 3) for primary sections
- Reflective badges (no push notifications)

## Scoring and Messaging
> **Detailed guidance:** See [ux-gamification-psychology.md](ux-gamification-psychology.md)

- Points formula: +10 per prayer logged, +5 daily completion bonus, +50 monthly 90%+ consistency bonus
- Points label: "Consistency score" (optional display, hideable)
- Completion percentage is the primary progress metric
- Reflective badges: First Prayer Logged, Week of Consistency (7 days), Month Complete (90%+), Season Champion (3 months 80%+)
- Notification templates use supportive placeholders; no shame language

## Time Formatting
- Time display follows device locale (12/24) with no manual override in v1

## Build and Runtime Configuration
- Android minSdk: 23
- Version: 0.1.0+1
- Sentry DSN via env file using flutter_dotenv

## Non-Functional Requirements
- Offline-first: no network required for core use
- Arabic RTL by default with Cairo font
- Efficient performance on mid-range Android devices
- Minimal battery impact and responsible scheduling
- UX/gamification/psychology alignment per [ux-gamification-psychology.md](ux-gamification-psychology.md)

## Settings
- Prayer times per prayer
- Reminder offsets per prayer
- End-of-day reminder time
- Notifications per prayer + daily summary toggle (opt-in by default)
- Haptics and vibration toggle
- Points display toggle (show/hide)
- Language selector (supportedLocales)
- Theme selector (light/dark/system)
- Calendar week start (default Sunday)
- App Lock controls (enable/disable, PIN change)
- Bottom navigation between Today, Calendar, Settings

## Data Model
> **Implementation:** See `lib/features/prayer/domain/models/`

| Model | Fields | Purpose |
|-------|--------|---------|
| `PrayerDay` | date, entries[], isComplete, points | One day's prayer data |
| `PrayerEntry` | type, scheduledAt, isCompleted, checkedAt | One prayer's status |
| `PrayerType` | fajr, dhuhr, asr, maghrib, isha | Prayer enum |
| `Settings` | locale, themeMode, showPoints | User preferences |

## Security
- App Lock triggers only after device screen off/lock
- Biometrics + PIN fallback
- No encryption at rest for v1

## Analytics/Crash Reporting
- Sentry free tier only
- PII scrubbing enabled, minimal breadcrumbs

## Edge Cases Covered
- Past time scheduling
- Timezone/DST changes
- Duplicate reminders on settings changes
- iOS screen-off detection limitations
- Streak recalculation after edits

## Release Criteria (MVP)
- All five prayers can be logged and persisted offline
- Streaks and points update accurately
- Calendar reflects daily status
- Notifications fire correctly and are editable
- Arabic default with EN/FR selectable
- App Lock works after device screen off
- Signed APK + signed AAB generated by CI

---
> **Next:** [plan.md](plan.md) for implementation phases

