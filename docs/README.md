# Documentation - سجل الصلاة

## Overview
This directory contains enterprise-grade documentation for the Salat Tracker app. All documents are designed to work together as a cohesive ecosystem.

## Document Map

| Document | Purpose | When to Use |
|----------|---------|-------------|
| [prd.md](prd.md) | Product requirements, user stories, scope | Define WHAT to build |
| [plan.md](plan.md) | Implementation phases, locked decisions, roadmap | Define WHEN to build |
| [design-system.md](design-system.md) | Visual specs, colors, typography, components | Define HOW it looks |
| [rules.md](rules.md) | Engineering standards, best practices, persona | Define HOW to code |
| [tasks.md](tasks.md) | Detailed checklist, current status, progress | Track progress |
| [ux-gamification-psychology.md](ux-gamification-psychology.md) | UX philosophy, gamification safety, tone | Validate decisions |

## Document Relationships

```
┌─────────────────────────────────────────────────────────────┐
│                         prd.md                              │
│              (What to build, why it matters)                │
└─────────────────────┬───────────────────────────────────────┘
                      │
          ┌───────────┴───────────┐
          ▼                       ▼
┌─────────────────┐     ┌─────────────────────────────────────┐
│    plan.md      │     │   ux-gamification-psychology.md     │
│ (Phases, order) │     │    (Safety, tone, philosophy)       │
└────────┬────────┘     └─────────────────────────────────────┘
         │                              │
         ▼                              │
┌─────────────────┐                     │
│   tasks.md      │◀────────────────────┘
│ (Detailed work) │        (Validates all messaging)
└────────┬────────┘
         │
         │ Implementation
         ▼
┌─────────────────┐     ┌─────────────────┐
│ design-system.md│◀───▶│    rules.md     │
│  (Visual specs) │     │ (Code standards) │
└─────────────────┘     └─────────────────┘
```

## Quick Start

1. **New to project?** Start with [prd.md](prd.md) → [plan.md](plan.md) → [tasks.md](tasks.md)
2. **Building UI?** Reference [design-system.md](design-system.md) and [ux-gamification-psychology.md](ux-gamification-psychology.md)
3. **Writing code?** Follow [rules.md](rules.md) and check tasks in [tasks.md](tasks.md)
4. **Reviewing copy?** Use [ux-gamification-psychology.md](ux-gamification-psychology.md) for tone validation

## Current Status

| Phase | Status | Description |
|-------|--------|-------------|
| Phase 1 | ✅ Complete | Foundations (structure, routing, theme) |
| Phase 2 | ✅ Complete | Data Layer (models, repositories, services) |
| Phase 3 | 🔄 In Progress | Core UX (Today screen, prayer log) |
| Phase 4 | ⬜ Not Started | Notifications |
| Phase 5 | ⬜ Not Started | App Lock |
| Phase 6 | ⬜ Not Started | Quality & Release |

## Locked Decisions

These decisions are **final** and documented in [plan.md](plan.md):

- **App name:** سجل الصلاة (AR) / Salat Tracker (EN fallback)
- **Architecture:** Feature-first + Clean layers
- **State:** Riverpod 3 + Freezed 3
- **Storage:** Hive CE (offline-first)
- **Gamification:** Progress > Streaks, no shame language
- **Theme:** Light/dark parity, Material 3, Cairo font

## Versioning

- **Docs version:** 1.1.0
- **App version:** 0.1.0+1
- **Last updated:** 2026-01-20
