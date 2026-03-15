# Project Plan - سجل الصلاة

> **Part of:** [Documentation Ecosystem](README.md) | **Related:** [prd.md](prd.md), [tasks.md](tasks.md)

## Overview
Offline-first Flutter app for daily prayer consistency with respectful UX,
reminders, calendar reflection, and strong privacy defaults.
Arabic-first (RTL) with English and French support.

## Decisions Locked
> ⚠️ These are **final**. Do not change without explicit user approval.

| Category | Decision |
|----------|----------|
| **App name** | سجل الصلاة (AR), Salat Tracker (EN fallback) |
| **Package ID** | com.carbodex.salat_tracker |
| **Architecture** | Feature-first + clean layers |
| **State** | Riverpod 3 + Freezed 3 |
| **Storage** | Hive CE (no encryption for v1) |
| **Notifications** | Per-prayer offsets + configurable daily reminders list |
| **Location Display** | GPS+API resolved context (`geolocator` + `timeapi.io` + `geocoding`) with cache/device/UTC fallback |
| **App Lock** | Biometrics + PIN; trigger only after screen-off/device-lock background->resume path |
| **Analytics** | Sentry (free tier) |
| **CI/CD** | Signed APK + AAB via GitHub Actions |
| **Font** | Cairo (bundled) |
| **Navigation** | Bottom NavigationBar: Today, Calendar, Settings |
| **Gamification** | Progress > Streaks; reflective badges only |
| **Theme** | Light/dark parity; no theme bias |
| **minSdk** | Android 23 |
| **Version** | 0.1.7+9 |

## Implementation Phases (Production Finalization)

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

### Phase 3: Core UX ✅
> **Status:** Complete

- [x] Today screen: checklist + progress (percentage primary) + quick log + supportive summary
- [x] Calendar view: month grid with day status colors
- [x] Day detail + history editing with streak impact message
- [x] Settings: prayer times, offsets, language, theme, notifications, haptics

**Acceptance Criteria:**
- User can log all 5 prayers
- Progress percentage is primary, streak secondary
- Data persists and syncs across screens

---

### Phase 4: Advanced Features + Notifications + Badges ✅
> **Status:** Complete

#### Completed
- [x] Schedule 5 daily reminders with per-prayer offsets
- [x] Replace single end-of-day reminder with configurable daily reminders list
- [x] Add onboarding late-day reminder time selection
- [x] Handle permissions (Android 13+), timezone/settings rescheduling
- [x] Notification tap deep-links to Today screen
- [x] Show user-facing timezone label in Prayer Schedule (city + UTC offset when derivable)
- [x] Add global compact location context banner on Today, Calendar, and Settings
- [x] Supportive copy only (validated by [ux-gamification-psychology.md](ux-gamification-psychology.md))

#### Remaining
- [ ] Validate timezone and DST-safe scheduling rules with tests
- [x] Ensure deterministic notification ID strategy to prevent duplicates
- [ ] Verify reboot/package-update rescheduling consistency
- [x] Add timezone fallback chain for display (`city -> zone id -> UTC`)
- [x] Add production fallback chain for resolution (`manual -> gps/api -> cache -> device -> UTC`)
- [x] Define reflective badge taxonomy (non-competitive)
- [x] Implement badge domain model and persistence
- [x] Implement badge evaluation engine and recomputation triggers
- [x] Add badges UI and EN/AR/FR localization
- [x] Add badge UI widget tests

#### Newly Completed
- [x] Define reflective badge taxonomy via first-prayer, week-consistency,
      month-complete, and season-champion badges
- [x] Add automated tests for notification scheduling edge cases
- [x] Add badge logic unit tests

**Acceptance Criteria:**
- Notifications fire correctly across timezone and DST changes
- Scheduling remains stable across app restart/reboot/update
- Badges are reflective (no pressure mechanics) and fully localized

---

### Phase 5: App Lock and Security Hardening ✅
> **Status:** Complete

#### Completed
- [x] Security providers and app lock route wired into router redirect flow
- [x] Biometrics + PIN UI foundation added (`local_auth`, `flutter_secure_storage`, `pinput`)
- [x] Standardize PIN UX to OTP-style cells for lock, setup, and reset flows

#### Remaining
- [x] Move app lock enable flag to Settings model (preference domain)
- [x] Replace plaintext PIN storage with salted hash verification
- [x] Add safe migration for existing security state
- [x] Implement lifecycle observer for foreground/background transitions
- [x] Enforce lock only after screen-off/device-lock background->resume path
- [x] Wire onboarding app lock step to real setup flow (not placeholder)
- [x] Add lockout/backoff policy for repeated invalid PIN attempts
- [x] Add unit tests for lock behavior
- [x] Add widget tests for lock behavior
- [ ] Add integration tests for lifecycle lock behavior
- [x] Add settings credential reset flow
- [x] Document best-effort iOS behavior and edge cases

**Acceptance Criteria:**
- Lock gate appears only after intended screen-off/device-lock path
- PIN is never stored plaintext
- Biometrics + PIN fallback works across cold start and resume scenarios

---

### Phase 6: Quality Engineering 🔄
> **Status:** Complete

- [x] Unit tests: streak, points, prayer repository, settings repository
- [x] Unit tests: security policy and notifications schedule
- [ ] Widget tests: full onboarding path (including lock setup)
- [ ] Integration smoke tests: launch -> onboarding -> logging -> calendar -> lock -> notification deep-link
- [x] RTL and localization verification (EN/AR/FR)
- [x] Enforce analyzer/format gates in CI
- [x] Enforce coverage threshold in CI
- [x] Accessibility checks (contrast, touch targets, semantics)
- [x] Performance checks on core flows (no visible jank)

#### UI Re-Art Completion
- [x] Introduce shared UI primitives and apply them across feature surfaces
- [x] Re-art Today, Calendar, Settings, Onboarding, Security, and Badges UIs
- [x] Complete RTL and localization parity pass for re-arted components

**Acceptance Criteria:**
- All tests pass
- No P0/P1 defects open in core flows
- Quality gates are green in CI

---

### Phase 7: Release Engineering and Store Readiness ✅
> **Status:** Complete

- [x] Add GitHub Actions CI workflow (format + analyze + tests)
- [x] Add signed APK and AAB build workflows
- [x] Add artifact retention and release tagging workflow
- [x] Validate signing, env wiring, and secret hygiene
- [x] Enforce compile-time secrets injection via `--dart-define` in CI/release workflows
- [x] Finalize icon/splash/store media and listing copy
- [x] Finalize privacy policy and in-app link
- [x] Prepare release notes and versioning process

### Phase 7.5: In-App Update Management ✅
> **Status:** Complete

- [x] Add channel-aware update architecture (Play vs GitHub/sideload)
- [x] Add Settings-only update tile with stateful UX (check, download, install, retry)
- [x] Add GitHub manifest + latest release fallback resolution
- [x] Add 72h grace policy for minimum-supported versions
- [x] Add hard-block route when grace expires
- [x] Add AR/EN/FR localization for update states and actions
- [x] Add unit tests for update policy engine and manifest parsing
- [x] Split Android distribution into `play` and `sideload` flavors for policy-safe permissions
- [x] Restrict `REQUEST_INSTALL_PACKAGES` to sideload flavor only
- [x] Add release SHA artifact generation and update-manifest synchronization runbook

**Acceptance Criteria:**
- Settings provides clear update status and actions without disturbing core screens
- Play-installed builds use Play update flow
- GitHub-installed builds can download latest APK and launch system installer
- Required updates respect grace window and then enforce hard block
- Play release artifacts are produced without sideload installer permission
- Update manifest contract is validated (version ordering, HTTPS URLs, SHA format)

**Acceptance Criteria:**
- Release candidate build is reproducible and signed
- Store assets and policy links are complete

---

### Phase 8: Launch Audit and Go/No-Go ✅
> **Status:** Complete

- [x] Run final doc-code parity audit (README/plan/tasks/prd/rules)
- [x] Security audit pass (PIN hashing, lifecycle lock correctness)
- [x] Notification audit pass (reliability, no duplicate scheduling)
- [x] Accessibility and performance audits pass
- [x] Conduct go/no-go review with objective release gates

**Acceptance Criteria:**
- No open P0/P1 defects
- CI green on protected branch
- Stakeholder signoff completed

---

## Phase Dependencies

```
Phase 1 ─────────► Phase 2 ─────────► Phase 3 ─────────► Phase 4 ─────────► Phase 5 ─────────► Phase 6 ─────────► Phase 7 ─────────► Phase 8
(Foundations)     (Data)             (Core UX)          (Advanced/Notif/Badges) (App Lock/Security) (Quality)       (Release)        (Go/No-Go)
```

---

## 🚀 Future Roadmap (Post v1.0)
The following features are approved for implementation in subsequent major updates:

1. **Home Screen Widgets**: Instantly view the next prayer time and your daily progress without opening the app.
2. **Cloud Sync & Backup**: Secure, opt-in cloud synchronization (via Firebase/Supabase) to restore authentic prayer history across devices.
3. **Qibla Compass**: A beautifully designed, minimalist Qibla direction finder.

---
> **Next:** [tasks.md](tasks.md) for detailed checklist

---

### Phase 10: Notification Entry Flow and UX Consistency ✅
> **Status:** Complete

- [x] Add structured notification intent model/payload contract (versioned, fallback-safe)
- [x] Add notification tap coordinator and pending-intent persistence
- [x] Add universal full-screen notification entry route with type-specific variants
- [x] Implement prayer action semantics: one-tap **Mark as done** (non-toggle)
- [x] Add snooze guard: only one active snooze per root intent
- [x] Fix onboarding notifications path to keep scheduling flow enabled when reminder setup detail is skipped
- [x] Refine Daily Reminders UX: generic title, simplified tile layout, app-bar multi-delete selection mode
- [x] Add/refresh tests for notification intents/coordinator/entry and updated onboarding/reminders flows

**Acceptance Criteria:**
- Notification tap flows are deterministic and route to the right entry/action state
- Prayer "Mark as done" persists completion before navigation
- Daily reminders delete flow is clear (enter selection from app-bar delete, then delete selected)
- Onboarding path does not leave notifications unscheduled due to skipped reminder details
