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
| **App Lock** | Biometrics + PIN; trigger only after screen-off/device-lock background->resume path |
| **Analytics** | Sentry (free tier) |
| **CI/CD** | Signed APK + AAB via GitHub Actions |
| **Font** | Cairo (bundled) |
| **Navigation** | Bottom NavigationBar: Today, Calendar, Settings |
| **Gamification** | Progress > Streaks; reflective badges only |
| **Theme** | Light/dark parity; no theme bias |
| **minSdk** | Android 23 |
| **Version** | 0.1.0+1 |

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

### Phase 4: Advanced Features + Notifications + Badges 🔄
> **Status:** In Progress

#### Completed
- [x] Schedule 5 daily reminders with per-prayer offsets
- [x] End-of-day reminder at Isha + 2 hours (editable)
- [x] Handle permissions (Android 13+), timezone/settings rescheduling
- [x] Notification tap deep-links to Today screen
- [x] Supportive copy only (validated by [ux-gamification-psychology.md](ux-gamification-psychology.md))

#### Remaining
- [ ] Validate timezone and DST-safe scheduling rules with tests
- [ ] Ensure deterministic notification ID strategy to prevent duplicates
- [ ] Verify reboot/package-update rescheduling consistency
- [ ] Define reflective badge taxonomy (non-competitive)
- [ ] Implement badge domain model and persistence
- [ ] Implement badge evaluation engine and recomputation triggers
- [ ] Add badges UI and EN/AR/FR localization
- [ ] Add badge logic and UI tests

**Acceptance Criteria:**
- Notifications fire correctly across timezone and DST changes
- Scheduling remains stable across app restart/reboot/update
- Badges are reflective (no pressure mechanics) and fully localized

---

### Phase 5: App Lock and Security Hardening 🔄
> **Status:** In Progress

#### Completed
- [x] Security providers and app lock route wired into router redirect flow
- [x] Biometrics + PIN UI foundation added (`local_auth`, `flutter_secure_storage`, `pinput`)

#### Remaining
- [ ] Move app lock enable flag to Settings model (preference domain)
- [ ] Replace plaintext PIN storage with salted hash verification
- [ ] Add safe migration for existing security state
- [ ] Implement lifecycle observer for foreground/background transitions
- [ ] Enforce lock only after screen-off/device-lock background->resume path
- [ ] Wire onboarding app lock step to real setup flow (not placeholder)
- [ ] Add lockout/backoff policy for repeated invalid PIN attempts
- [ ] Add unit/widget/integration tests for lock behavior
- [ ] Document best-effort iOS behavior and edge cases

**Acceptance Criteria:**
- Lock gate appears only after intended screen-off/device-lock path
- PIN is never stored plaintext
- Biometrics + PIN fallback works across cold start and resume scenarios

---

### Phase 6: Quality Engineering ⬜
> **Status:** Not Started

- [ ] Unit tests: streak, points, repositories, security policy, notifications schedule
- [ ] Widget tests: Today, Calendar details, Settings selectors, Onboarding + lock setup
- [ ] Integration smoke tests: first launch -> onboarding -> logging -> calendar -> lock -> notification deep-link
- [ ] RTL and localization verification (EN/AR/FR)
- [ ] Enforce analyzer/format gates and coverage threshold in CI
- [ ] Accessibility checks (contrast, touch targets, semantics)
- [ ] Performance checks on core flows (no visible jank)

**Acceptance Criteria:**
- All tests pass
- No P0/P1 defects open in core flows
- Quality gates are green in CI

---

### Phase 7: Release Engineering and Store Readiness ⬜
> **Status:** Not Started

- [ ] Add GitHub Actions CI workflow (format + analyze + tests)
- [ ] Add signed APK and AAB build workflows
- [ ] Add artifact retention and release tagging workflow
- [ ] Validate signing, env wiring, and secret hygiene
- [ ] Finalize icon/splash/store media and listing copy
- [ ] Finalize privacy policy and in-app link
- [ ] Prepare release notes and versioning process

**Acceptance Criteria:**
- Release candidate build is reproducible and signed
- Store assets and policy links are complete

---

### Phase 8: Launch Audit and Go/No-Go ⬜
> **Status:** Not Started

- [ ] Run final doc-code parity audit (README/plan/tasks/prd/rules)
- [ ] Security audit pass (PIN hashing, lifecycle lock correctness)
- [ ] Notification audit pass (reliability, no duplicate scheduling)
- [ ] Accessibility and performance audits pass
- [ ] Conduct go/no-go review with objective release gates

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
> **Next:** [tasks.md](tasks.md) for detailed checklist
