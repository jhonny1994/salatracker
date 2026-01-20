# Task List - سجل الصلاة

## 1) Project Initialization
- [x] Create Flutter project and lock package name (com.carbodex.salat_tracker)
- [x] Configure very_good_analysis and analysis rules
- [x] Set up feature-first folder structure
- [x] Add Riverpod + Freezed + build_runner
- [x] Establish navigation shell (bottom NavigationBar: Today, Calendar, Settings)
- [x] Set app version to 0.1.0+1 and minSdk 23

## 2) Localization and Typography
- [x] Configure flutter_intl + intl_utils + Localizely
- [x] Use ARB naming: intl_en.arb, intl_ar.arb, intl_fr.arb
- [x] Derive supported locales from generated S.delegate
- [x] Add locale_names and map supportedLocales to localized display names
- [x] Bundle Cairo font assets and set as default TextTheme
- [x] Set display names: AR "سجل الصلاة", EN "Salat Tracker" (fallback for all others)
- [x] Set prayer names: AR "الفجر، الظهر، العصر، المغرب، العشاء"; EN "Fajr, Dhuhr, Asr, Maghrib, Isha"
- [x] Verify RTL Directionality and bidi text handling

## 3) Design System and Theme
- [x] Implement Material 3 theme with tokenized ColorScheme
- [x] Enforce light/dark parity in ThemeData
- [x] Apply design system component defaults (Card, ListTile, FilledButton)
- [x] Add status chip styles (complete/partial/not logged)

## 4) Onboarding Flow
- First-launch flow with prayer time setup
- Notification opt-in prompt (supportive language)
- App Lock opt-in (biometrics + PIN)
- Default settings confirmation (theme, language, week start)

## 5) Data Layer
- Define Freezed models (PrayerDay, PrayerEntry, Settings)
- Create Hive CE adapters and boxes
- Add box versioning and migration strategy
- Repository interfaces for future backend swap

## 6) Prayer Log (Today)
- Today screen UI and state
- Toggle prayer completion with timestamps
- Completion percentage primary, streak secondary in UI
- Points calculation per prayer and per day (transparent formula)
- Supportive summary copy (no shame language)

## 7) Streaks and Badges
- Full-day completion rule
- Streak recalculation after edits
- Rolling weekly/monthly percentage computation
- Reflective badges (no push notifications)
- Badges: First Prayer Logged, Week of Consistency (7 days), Month Complete (90%+), Season Champion (3 months 80%+)
- Points formula: +10 per prayer, +5 daily completion, +50 monthly 90%+

## 8) Calendar and History
- Month view with status colors
- Day detail screen
- History editing flow with streak impact notice
- Badge summary entry point (optional view)

## 9) Notifications
- Schedule per-prayer reminders with offsets
- End-of-day reminder default Isha + 2 hours (editable)
- Reschedule on timezone or settings changes
- Handle notification permissions (Android 13+)
- Deep-link from notification to Today screen
- Supportive notification copy (no shame language)
- Use device locale for time formatting in notifications

## 10) App Lock
- Biometrics with PIN fallback
- Screen-off/lock detection (Android exact, iOS best-effort)
- Secure storage for PIN hash and lock state
- Lock gate on resume after device screen off

## 11) Settings
- Prayer times per prayer
- Offsets per prayer
- End-of-day reminder time
- Theme mode (light/dark/system)
- Haptics and vibration toggle
- Points display toggle
- Language selector (supportedLocales)
- App Lock controls (enable/disable, PIN change)
- Calendar week start (default Sunday)

## 12) Analytics and Crash Reporting
- [x] Add sentry_flutter
- [x] Add flutter_dotenv and .env.example with SENTRY_DSN
- [x] Configure DSN per build flavor using env
- [x] PII scrubbing and minimal breadcrumbs

## 13) CI/CD and Signing
- GitHub Actions lint + tests
- Signed APK + signed AAB builds
- Keystore and signing secrets setup
- Artifact upload and versioned releases
- Use env example for Sentry DSN (no secrets committed)

## 14) Brand Assets (Pre-Production)
- App icon set
- Splash screen assets
- Play Store listing media

## 15) QA and Release Readiness
- Unit tests for streaks, points, and data integrity
- Notification scheduling tests
- RTL layout checks and bidi text verification
- Theme parity testing (light/dark)
- Supportive copy audit (no shame language)
- UX/gamification/psychology checklist review (docs/ux-gamification-psychology.md)
- Release smoke tests on Android
- Play Store listing assets and privacy policy
