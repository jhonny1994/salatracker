# Task List - سجل الصلاة

> **Part of:** [Documentation Ecosystem](README.md) | **Aligned with:** [plan.md](plan.md)

## Progress Summary

| Phase | Progress | Status |
|-------|----------|--------|
| Phase 1: Foundations | 6/6 | ✅ Complete |
| Phase 2: Data Layer | 7/7 | ✅ Complete |
| Phase 3: Core UX | 1/10 | 🔄 In Progress |
| Phase 4: Notifications | 0/5 | ⬜ Not Started |
| Phase 5: App Lock | 0/4 | ⬜ Not Started |
| Phase 6: Quality | 0/9 | ⬜ Not Started |

---

## Phase 1: Foundations ✅

- [x] Create Flutter project and lock package name (com.carbodex.salat_tracker)
- [x] Configure very_good_analysis and analysis rules
- [x] Set up feature-first folder structure
- [x] Add Riverpod + Freezed + build_runner
- [x] Establish navigation shell (bottom NavigationBar: Today, Calendar, Settings)
- [x] Set app version to 0.1.0+1 and minSdk 23

**Localization (Phase 1 subset):**
- [x] Configure flutter_intl + intl_utils
- [x] Use ARB naming: intl_en.arb, intl_ar.arb, intl_fr.arb
- [x] Derive supported locales from generated S.delegate
- [x] Add locale_names and map supportedLocales to localized display names
- [x] Bundle Cairo font assets and set as default TextTheme
- [x] Set display names: AR "سجل الصلاة", EN "Salat Tracker"
- [x] Set prayer names: AR "الفجر، الظهر، العصر، المغرب، العشاء"; EN "Fajr, Dhuhr, Asr, Maghrib, Isha"
- [x] Verify RTL Directionality and bidi text handling

**Design System (Phase 1 subset):**
- [x] Implement Material 3 theme with tokenized ColorScheme
- [x] Enforce light/dark parity in ThemeData
- [x] Apply design system component defaults (Card, ListTile, FilledButton)
- [x] Add status chip styles (complete/partial/not logged)
- [x] Add StatusChipTheme extension

---

## Phase 2: Data Layer ✅

**Models:**
- [x] PrayerType enum with Hive adapter
- [x] PrayerEntry Freezed model with Hive adapter
- [x] PrayerDay Freezed model with Hive adapter
- [x] Settings Freezed model with Hive adapter
- [x] AppThemeMode enum with Hive adapter

**Services:**
- [x] StreakCalculator service
- [x] PointsCalculator service
- [x] DateTimeX shared extension

**Infrastructure:**
- [x] HiveService for box management
- [x] PrayerLocalDataSource
- [x] SettingsLocalDataSource
- [x] PrayerRepository interface + implementation
- [x] SettingsRepository interface + implementation
- [x] Riverpod providers for all dependencies
- [x] Sentry integration with PII scrubbing

---

## Phase 3: Core UX 🔄

### Today Screen
- [/] Today screen UI skeleton
- [ ] Prayer checklist with toggle
- [ ] Completion percentage (primary metric)
- [ ] Streak display (secondary metric)
- [ ] Points chip (optional display)
- [ ] Supportive summary copy
- [ ] Smooth toggle animation (150ms)

### Calendar
- [ ] Month view with TableCalendar
- [ ] Day status colors (complete/partial/not logged)
- [ ] Day detail screen
- [ ] History editing with streak impact notice

### Settings
- [ ] Prayer times configuration
- [ ] Reminder offset configuration
- [ ] End-of-day reminder time
- [ ] Theme mode selector (light/dark/system)
- [ ] Language selector
- [ ] Points display toggle
- [ ] Haptics toggle
- [ ] Calendar week start

### Onboarding
- [ ] First-launch detection
- [ ] Prayer time setup flow
- [ ] Notification opt-in prompt (supportive language)
- [ ] App Lock opt-in
- [ ] Default settings confirmation

---

## Phase 4: Notifications ⬜

- [ ] Schedule per-prayer reminders with offsets
- [ ] End-of-day reminder (Isha + 2 hours default)
- [ ] Reschedule on timezone/settings changes
- [ ] Handle notification permissions (Android 13+)
- [ ] Deep-link from notification to Today screen
- [ ] Supportive notification copy (validated by [ux-gamification-psychology.md](ux-gamification-psychology.md))

---

## Phase 5: App Lock ⬜

- [ ] Biometrics authentication
- [ ] PIN fallback setup
- [ ] Screen-off/lock detection (Android exact, iOS best-effort)
- [ ] Lock gate on resume
- [ ] Secure storage for PIN hash

---

## Phase 6: Quality & Release ⬜

**Testing:**
- [ ] Unit tests for StreakCalculator
- [ ] Unit tests for PointsCalculator
- [ ] Unit tests for data layer
- [ ] Widget tests for Today screen
- [ ] Notification scheduling tests
- [ ] RTL layout verification

**QA Checklist:**
- [ ] Light/dark parity testing
- [ ] Supportive copy audit (no shame language)
- [ ] UX/gamification/psychology review per [ux-gamification-psychology.md](ux-gamification-psychology.md)
- [ ] Performance: 60 FPS on mid-range device
- [ ] Accessibility: contrast ratios and touch targets

**Release:**
- [ ] GitHub Actions CI/CD setup
- [ ] Signed APK generation
- [ ] Signed AAB generation
- [ ] App icon set
- [ ] Splash screen assets
- [ ] Play Store listing media
- [ ] Privacy policy

---

## Legend

| Symbol | Meaning |
|--------|---------|
| `[x]` | Complete |
| `[/]` | In Progress |
| `[ ]` | Not Started |
| ✅ | Phase Complete |
| 🔄 | Phase In Progress |
| ⬜ | Phase Not Started |

---
> **Implementation details:** [rules.md](rules.md) | **Visual specs:** [design-system.md](design-system.md)
