# Task List - سجل الصلاة

> **Part of:** [Documentation Ecosystem](README.md) | **Aligned with:** [plan.md](plan.md)

## Production Finalization Program (v1.0.0)

> Objective: ship a production-ready, business-grade Salat Tracker with hardened security, reliable notifications, full localization and RTL quality, and release automation.

### Product Decisions (Locked)
- [x] Badges are included in v1.
- [x] App Lock policy: lock only after screen-off/device lock or equivalent background->resume path.
- [x] Progress percentage is primary metric; streaks are secondary; points are optional.

---

## Progress Summary (Re-Baselined)

| Phase | Progress | Status |
|-------|----------|--------|
| Phase 1: Foundations | 6/6 | ✅ Complete |
| Phase 2: Data Layer | 7/7 | ✅ Complete |
| Phase 3: Core UX | 10/10 | ✅ Complete |
| Phase 4: Advanced Features + Notifications + Badges | 13/20 | 🔄 In Progress |
| Phase 5: App Lock & Security Hardening | 2/10 | 🔄 In Progress |
| Phase 6: Quality Engineering | 0/16 | ⬜ Not Started |
| Phase 7: Release Engineering & Store Readiness | 0/12 | ⬜ Not Started |
| Phase 8: Launch Audit & Go/No-Go | 0/8 | ⬜ Not Started |

---

## Phase 1: Foundations ✅

- [x] Create Flutter project and lock package name (com.carbodex.salat_tracker).
- [x] Configure very_good_analysis and analysis rules.
- [x] Set up feature-first folder structure.
- [x] Add Riverpod + Freezed + build_runner.
- [x] Establish navigation shell (bottom NavigationBar: Today, Calendar, Settings).
- [x] Set app version to 0.1.0+1 and minSdk 23.

**Localization (Phase 1 subset):**
- [x] Configure flutter_intl + intl_utils.
- [x] Use ARB naming: intl_en.arb, intl_ar.arb, intl_fr.arb.
- [x] Derive supported locales from generated S.delegate.
- [x] Add locale_names and map supportedLocales to localized display names.
- [x] Bundle Cairo font assets and set as default TextTheme.
- [x] Set display names: AR "سجل الصلاة", EN "Salat Tracker".
- [x] Set prayer names: AR "الفجر، الظهر، العصر، المغرب، العشاء"; EN "Fajr, Dhuhr, Asr, Maghrib, Isha".
- [x] Verify RTL Directionality and bidi text handling.

**Design System (Phase 1 subset):**
- [x] Implement Material 3 theme with tokenized ColorScheme.
- [x] Enforce light/dark parity in ThemeData.
- [x] Apply design system component defaults (Card, ListTile, FilledButton).
- [x] Add status chip styles (complete/partial/not logged).
- [x] Add StatusChipTheme extension.

---

## Phase 2: Data Layer ✅

**Models:**
- [x] PrayerType enum with Hive adapter.
- [x] PrayerEntry Freezed model with Hive adapter.
- [x] PrayerDay Freezed model with Hive adapter.
- [x] Settings Freezed model with Hive adapter.
- [x] AppThemeMode enum with Hive adapter.

**Services:**
- [x] StreakCalculator service.
- [x] PointsCalculator service.
- [x] DateTimeX shared extension.

**Infrastructure:**
- [x] HiveService for box management.
- [x] PrayerLocalDataSource.
- [x] SettingsLocalDataSource.
- [x] PrayerRepository interface + implementation.
- [x] SettingsRepository interface + implementation.
- [x] Riverpod providers for all dependencies.
- [x] Sentry integration with PII scrubbing.

---

## Phase 3: Core UX ✅

### Today Screen
- [x] Today screen UI skeleton.
- [x] Prayer checklist with toggle.
- [x] Completion percentage (primary metric).
- [x] Streak display (secondary metric).
- [x] Points chip (optional display).
- [x] Supportive summary copy.
- [x] Smooth toggle animation (150ms).

### Calendar
- [x] Month view with TableCalendar.
- [x] Day status colors (complete/partial/not logged).
- [x] Day detail screen.

### Settings
- [x] Theme mode selector (light/dark/system).
- [x] Language selector.
- [x] Points display toggle.
- [x] Haptics toggle.

---

## Phase 4: Advanced Features + Notifications + Badges 🔄

### Advanced Calendar & Settings
- [x] History editing with streak impact notice.
- [x] Prayer times configuration (manual schedule).
- [x] Reminder offset configuration.
- [x] Calendar week start.

### Onboarding
- [x] First-launch detection.
- [x] Prayer time setup flow.
- [x] Notification opt-in prompt (supportive language).
- [x] App Lock opt-in (UI step present; full setup wired in Phase 5).
- [x] Default settings confirmation.

### Notifications Reliability
- [x] Schedule per-prayer reminders.
- [x] End-of-day reminder (Isha + 2 hours default).
- [x] Reschedule on timezone/settings changes.
- [x] Handle notification permissions (Android 13+).
- [x] Deep-link from notification to Today screen.
- [x] Supportive notification copy (validated by [ux-gamification-psychology.md](ux-gamification-psychology.md)).
- [ ] Validate timezone and DST-safe scheduling rules with tests.
- [ ] Ensure deterministic notification ID strategy to prevent duplicates.
- [ ] Verify reboot/package-update rescheduling consistency.
- [ ] Add automated tests for scheduling edge cases.

### Badges (v1 Required)
- [ ] Define reflective badge taxonomy (non-competitive, no shame mechanics).
- [ ] Implement badge domain model + persistence.
- [ ] Implement badge evaluation engine (daily/weekly/monthly milestones).
- [ ] Trigger badge recomputation on prayer/history changes.
- [ ] Add badges UI screen (reflective history view).
- [ ] Add EN/AR/FR localization keys for badges.
- [ ] Add unit tests for badge awarding logic.
- [ ] Add widget test for badge UI rendering and states.

---

## Phase 5: App Lock & Security Hardening 🔄

### Security Data Model
- [ ] Move app-lock enabled flag to Settings model (preference domain).
- [ ] Keep PIN secret only in secure storage (secret domain).
- [ ] Migrate existing state safely without data loss.
- [ ] Replace plaintext PIN storage with salted hash verification.
- [ ] Add lockout/backoff policy for repeated invalid PIN attempts.

### Lifecycle Lock Policy
- [ ] Implement lifecycle observer for foreground/background transitions.
- [ ] Implement lock trigger only after screen-off/device-lock background->resume path.
- [ ] Ensure no lock interruption during uninterrupted foreground usage.
- [ ] Verify cold start, resume, and process-death behavior.

### UX Integration
- [ ] Wire onboarding app-lock step to real setup (PIN and optional biometrics).
- [ ] Add clear recovery paths when biometrics are unavailable/cancelled.
- [ ] Add settings controls for lock enable/disable and credential reset.

### Validation
- [ ] Unit tests for security repository and lock policy decisions.
- [ ] Widget tests for lock screen interactions.
- [ ] Integration tests for lifecycle lock behavior.

---

## Phase 6: Quality Engineering ⬜

### Automated Testing
- [ ] Unit tests: StreakCalculator.
- [ ] Unit tests: PointsCalculator.
- [ ] Unit tests: Prayer repository.
- [ ] Unit tests: Settings repository.
- [ ] Unit tests: notification scheduling logic.
- [ ] Unit tests: security repository and lock policy.
- [ ] Widget tests: Today interactions (toggle/progress).
- [ ] Widget tests: Calendar day detail and history edits.
- [ ] Widget tests: Settings toggles and selectors.
- [ ] Widget tests: Onboarding full path (including lock setup).
- [ ] Integration smoke tests: first launch -> onboarding -> logging -> calendar -> lock -> notification deep-link.
- [ ] RTL layout verification tests.
- [ ] EN/AR/FR localization completeness checks.

### Static Quality
- [ ] Enforce formatting and analyzer clean state.
- [ ] Zero critical analyzer/lint violations in release branch.
- [ ] Coverage threshold gate defined and enforced in CI.

---

## Phase 7: Release Engineering & Store Readiness ⬜

### CI/CD
- [ ] Add CI workflow: format + analyze + tests.
- [ ] Add build workflow: signed APK generation.
- [ ] Add build workflow: signed AAB generation.
- [ ] Add artifact retention and release tagging workflow.

### Security & Config Hygiene
- [ ] Validate no secrets committed (.env policy + checks).
- [ ] Verify Sentry environment wiring per build flavor.
- [ ] Validate release signing configs and key management process.

### Product Ops Readiness
- [ ] App icon set finalized.
- [ ] Splash assets finalized.
- [ ] Play Store listing media and copy finalized.
- [ ] Privacy policy finalized and accessible in-app.
- [ ] Versioning/changelog/release notes process finalized.

---

## Phase 8: Launch Audit & Go/No-Go ⬜

### Final Audit
- [ ] Doc-code parity audit (README/plan/tasks/prd/rules aligned).
- [ ] Security audit pass (PIN hashing, storage boundaries, lifecycle lock correctness).
- [ ] Notification audit pass (reliability and no duplicate schedules).
- [ ] Accessibility audit pass (contrast, semantics, touch targets).
- [ ] Performance audit pass (no visible jank in core flows).

### Go/No-Go Criteria
- [ ] No open P0 defects.
- [ ] No open security-critical/P1 defects.
- [ ] CI green on protected branch.
- [ ] Release candidate signed and install-verified.
- [ ] Stakeholder signoff completed.

---

## Severity & Defect Policy

- P0: crash, data loss, auth/lock bypass, severe notification malfunction. Must fix before release.
- P1: major flow breakage, critical UX inconsistency, persistent functional bug. Must fix before release.
- P2: moderate issues with workaround. Fix before release or queue for first patch release.
- P3: minor polish/cosmetic. Backlog unless bundled safely.

Exit rule:
- Release is blocked if any P0 or P1 defect is open.

---

## KPI & SLO Targets (Release Baseline)

- Crash-free sessions >= 99.5% (first 30 days).
- Core action success (log prayer toggle) >= 99.9%.
- Notification schedule consistency >= 99% (test matrix).
- Startup median < 2s on mid-range Android profile.
- RTL and localization parity: 100% primary screens EN/AR/FR audited.

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
