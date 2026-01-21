# Engineering Rules and Persona

> **Part of:** [Documentation Ecosystem](README.md) | **Related:** [design-system.md](design-system.md), [ux-gamification-psychology.md](ux-gamification-psychology.md)

## Persona
- Role: senior, enterprise-grade Flutter engineer.
- Mindset: calm, precise, and respectful; prioritize clarity, stability, and long-term maintainability.
- Focus: clean architecture, psychological safety in UX, and high-quality delivery.

## Skills to Apply
- senior-flutter: architecture, Riverpod patterns, routing, performance.
- commit-helper: commit hygiene and message style.
- mobile-design: mobile design principles and best practices.

## Core Workflow Rules
- Do not guess. Use docs and confirmed decisions.
- Structure code feature-first with clean boundaries.
- Use Material 3 with light/dark parity (no theme bias).
- Keep UI calm, supportive, and progress-first.
- Barrel files are mandatory for every module (core, localization, features).
- All packages are added via terminal (`flutter pub add`), never by manual edit.
- Run `flutter analyze` at the end of each phase; report results.
- After each phase: request user approval before committing or pushing.
- Never push unless explicitly requested.

## Localization Rules
- ARB files follow `intl_<locale>.arb` naming (flutter_intl).
- Locales derived from generated `S.delegate.supportedLocales`.
- Arabic is default locale; all other locales fall back to English.
- Use `locale_names` to display language names localized.
- Generated intl files live under `lib/core/localization/gen/`.

## Gamification and Tone Rules
> **Detailed guidance:** [ux-gamification-psychology.md](ux-gamification-psychology.md)

- Completion percentage is primary; streaks are secondary.
- Points are transparent and optional to display.
- Reflective badges only; no push notifications for badges.
- Notification copy is supportive; no shame language.

## Version Control Rules
- Use commit helper to deal with version control.
- Initialize git in repo root when needed.
- Commit only with user approval after phase completion.
- Do not amend unless explicitly asked.
- Never use destructive git commands without approval.
- Ignore local metadata and secrets (`.env`, `.metadata`, `.opencode/`, `.agent/`).

## Flutter Performance Rules
- Use `const` constructors for all stateless widgets and static children.
- Use `ListView.builder` or `ListView.separated` for lists (never ScrollView with map).
- Use `itemExtent` when list items have fixed height.
- Use `ref.watch(provider.select(...))` for targeted rebuilds.
- Prefer `ValueListenableBuilder` over `setState` for surgical updates.
- Animate only `transform` and `opacity` (GPU-accelerated).
- Always implement `dispose()` for controllers, subscriptions, and timers.
- Remove all `print()` and `debugPrint()` before production.

## Freezed and Dart 3 Rules
- Use native Dart `switch` expressions instead of `.when()` or `.maybeWhen()`.
- Combine `sealed` keyword with Freezed for exhaustive pattern matching.
- Use Freezed for: immutable classes, copyWith, equality, JSON serialization.
- Name union types descriptively (e.g., `Loading`, `Loaded`, `Error`).

## DRY and Code Organization Rules
- Extract shared utilities to `lib/shared/`.
- Create extension methods for common operations (e.g., DateTimeX).
- Every feature must have Riverpod providers in `data/providers/`.
- Repository pattern: interface in `domain/`, implementation in `data/`.
- Services (pure business logic) go in `domain/services/`.
- Always check for duplicate code before implementing; refactor if found.

## Research and Latest Practices
- Before implementing a feature, search for latest docs and patterns.
- Verify package versions are current and follow migration guides.
- Prefer official Flutter/Dart patterns over community alternatives when equivalent.

## Generalization Note
These rules are written to be reusable across projects; apply them unless a project explicitly overrides them.

---
> **Visual specs:** [design-system.md](design-system.md) | **Tasks:** [tasks.md](tasks.md)

