# Project Plan - سجل الصلاة

> **Part of:** [Documentation Ecosystem](README.md) | **Related:** [prd.md](prd.md), [tasks.md](tasks.md)

## Overview
Offline-first Flutter app to gamify daily prayer completion with streaks, points, calendar history, and reminders. Arabic-first (RTL) with Cairo font and English fallback for all other locales. Android-first, iOS-ready.

## Decisions Locked
> ⚠️ These are **final**. Do not change without explicit user approval.

| Category | Decision |
|----------|----------|
| **App name** | سجل الصلاة (AR), Salat Tracker (EN fallback) |
| **Package ID** | com.carbodex.salat_tracker |
| **Architecture** | Feature-first + clean layers |
| **State** | Riverpod 3 + Freezed 3 |
| **Storage** | Hive CE (no encryption for v1) |
| **Notifications** | Per-prayer offsets + end-of-day (Isha +2h) |
| **App Lock** | Biometrics + PIN; trigger on screen off |
| **Analytics** | Sentry (free tier) |
| **CI/CD** | Signed APK + AAB via GitHub Actions |
| **Font** | Cairo (bundled) |
| **Navigation** | Bottom NavigationBar: Today, Calendar, Settings |
| **Gamification** | Progress > Streaks; reflective badges only |
| **Theme** | Light/dark parity; no theme bias |
| **minSdk** | Android 23 |
| **Version** | 0.1.0+1 |

## Implementation Phases

### Phase 1: Foundations ✅
> **Status:** Complete

- [x] Create Flutter project and feature-first structure
- [x] Add Riverpod + Freezed + build_runner + very_good_analysis
- [x] Add localization pipeline (flutter_intl + intl_utils)
- [x] Bundle Cairo font assets and set as default
- [x] Set up routing (go_router) and theme (light/dark/system)
- [x] Bottom navigation shell

**Acceptance Criteria:**
- App builds and runs
- Routing works between tabs
- Theme persists across restarts

---

### Phase 2: Data and Domain ✅
> **Status:** Complete

- [x] Define domain models (PrayerDay, PrayerEntry, PrayerType, Settings)
- [x] Implement Hive CE adapters and boxes
- [x] Repository interfaces for future backend swap
- [x] Implement streak and points calculation services
- [x] Riverpod providers for dependency injection
- [x] Shared date utilities (DateTimeX extension)

**Acceptance Criteria:**
- Models serialize/deserialize correctly
- Data persists offline
- Services calculate streaks and points accurately

---

### Phase 3: Core UX 🔄
> **Status:** In Progress

- [/] Today screen: checklist + progress (percentage primary) + quick log + supportive summary
- [ ] Calendar view: month grid with day status colors
- [ ] Day detail + history editing with streak impact message
- [ ] Settings: prayer times, offsets, language, theme, notifications, haptics
- [ ] Add badges view (reflective, no push)

**Acceptance Criteria:**
- User can log all 5 prayers
- Progress percentage is primary, streak secondary
- Data persists and syncs across screens

---

### Phase 4: Notifications ⬜
> **Status:** Not Started

- [ ] Schedule 5 daily reminders with per-prayer offsets
- [ ] End-of-day reminder at Isha + 2 hours (editable)
- [ ] Handle permissions (Android 13+), timezone/DST rescheduling
- [ ] Ensure notification tap deep-links to relevant prayer
- [ ] Supportive copy only (validated by [ux-gamification-psychology.md](ux-gamification-psychology.md))

**Acceptance Criteria:**
- Notifications fire at correct times
- Deep-link opens correct screen
- Copy passes supportive tone review

---

### Phase 5: App Lock ⬜
> **Status:** Not Started

- [ ] Onboarding prompt to enable/disable App Lock
- [ ] Lock triggered only after device screen off/lock
- [ ] Biometrics with PIN fallback
- [ ] Best-effort iOS implementation and documented behavior

**Acceptance Criteria:**
- Lock gate appears after screen off
- Biometrics authentication works
- PIN fallback functions correctly

---

### Phase 6: Quality and Release ⬜
> **Status:** Not Started

- [ ] Unit tests for streaks, points, data integrity
- [ ] Notification scheduling tests
- [ ] RTL layout checks and smoke tests
- [ ] Supportive copy review (no shame language)
- [ ] Sentry integration with PII scrubbing
- [ ] GitHub Actions builds signed APK + signed AAB
- [ ] Play Store readiness checklist and release notes
- [ ] Brand assets prep (icon, splash, store media)
- [ ] Follow [ux-gamification-psychology.md](ux-gamification-psychology.md) checklist

**Acceptance Criteria:**
- All tests pass
- No shame language in UI
- Signed builds upload successfully

---

## Phase Dependencies

```
Phase 1 ─────────► Phase 2 ─────────► Phase 3
(Foundations)     (Data)             (Core UX)
                                          │
                            ┌─────────────┼─────────────┐
                            ▼             ▼             ▼
                       Phase 4       Phase 5       Phase 6
                    (Notifications)  (App Lock)   (Quality)
```

---
> **Next:** [tasks.md](tasks.md) for detailed checklist
