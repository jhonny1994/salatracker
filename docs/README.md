# Salat Tracker Docs

This folder is the developer-facing documentation ecosystem for Salat Tracker.
It is intentionally concise and aligned with shipping work.

## How to use this docs set

- Start with `prd.md` for product scope and constraints
- Use `plan.md` for delivery decisions and phase status
- Use `tasks.md` as execution checklist
- Reference `rules.md` for engineering standards
- Reference `design-system.md` for UI consistency rules

## Document map

| File | Purpose |
|---|---|
| `prd.md` | Product requirements and boundaries |
| `plan.md` | Phase plan and locked decisions |
| `tasks.md` | Implementation checklist and quality gates |
| `rules.md` | Coding standards and workflow rules |
| `design-system.md` | Shared UI tokens, components, and patterns |
| `ux-gamification-psychology.md` | Tone and behavioral safety guidance |
| `release-signing-and-env.md` | Release pipeline, signing, and env runbook |

## Current baseline

- App version: `0.1.8+10`
- Docs baseline date: `2026-03-11`
- Architecture: feature-first + clean layers + Riverpod
- Platform focus: Android production, iOS-ready foundations

## Documentation principles

- Keep docs short, practical, and decision-oriented
- Prefer clear constraints over long narratives
- Keep product docs user-outcome focused
- Keep engineering docs implementation-focused
- Update docs in the same PR as behavior changes
