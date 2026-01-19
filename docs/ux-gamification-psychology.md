# UX, Gamification, and Psychology Consolidated Guide - سجل الصلاة

## Purpose
Single reference for UI quality, gamification safety, and psychology alignment. This guide consolidates the previous research and visual guidance into a unified, implementable playbook.

## Executive Summary
- Build a calm, respectful, enterprise-grade experience that supports intrinsic motivation.
- Use "white-hat" gamification: progress and reflection, not pressure or manipulation.
- Completion percentage is the primary metric; streaks are secondary.
- Notifications are opt-in and supportive. No shame language.
- Light/dark parity is required. No theme bias.
- Material 3, Cairo font, RTL correctness, and accessibility are non-negotiable.

## 1) Product and UX Principles
- Respect the spiritual context: no urgency loops, no shame triggers.
- Low friction daily flow: open app, mark prayers, see progress.
- Offline-first reliability: no network dependency for core use.
- Enterprise-grade = consistent tokens, polished behavior, and stable performance on mid-range devices.

## 2) Gamification Philosophy (White-Hat)
### Core Rules
- Progress > streaks. Show completion percentage first, streaks second.
- Points are reflective, not competitive. No XP, no leveling, no unlocks.
- Badges are retrospective and optional. No push notifications for badges.
- No leaderboards or social ranking.

### Streak Safety Model
- Streaks increment only on fully completed days.
- When a day is not logged, show progress context (weekly/monthly percentage) instead of failure.

### Points Guidance
- Transparent formula, visible in settings or info screen.
- Optional display: allow users to hide points if distracting.

## 3) Messaging Tone and Notifications
### Tone Rules
- Supportive and progress-forward.
- No shame, blame, or harsh language.
- Avoid words like "failed", "broken", "should", "must" in user-facing messages.
- Use neutral state labels like "not logged" only for status chips or calendars, not for motivational copy.

### Copy Examples
- Good: "You completed 4 of 5 prayers today (80%)."
- Good: "Solid progress this week. Ready to continue?"
- Avoid: "Your streak is broken." or "You failed to pray."

### Notification Strategy
- Opt-in during onboarding; default off until user accepts.
- Gentle timing: prayer time + user offset, plus end-of-day reminder.
- Supportive copy only. No penalty language.

## 4) Visual System and UI Direction
- Material Design 3 with Cairo typography.
- RTL-first layout using start/end alignment (no left/right hardcoding).
- Light/dark parity: design and QA both themes equally.
- Use tokenized ColorScheme values from the design system (no hardcoded hex in UI code).

## 5) Core Components
### Prayer Card
- Title (prayer name), time, status chip, trailing toggle.
- One-tap toggle with immediate feedback.
- Status chip must include text (not color-only).

### Progress Summary
- Primary metric: completion percentage.
- Secondary metric: streak count (subdued style).
- Optional: monthly consistency score (points).

### Calendar Day Cell
- Status indicator with accessible label.
- Tap opens day detail and edit history.

## 6) Motion and Micro-Interactions
- 150-300ms animations; ease-in-out or ease-out.
- Haptics are subtle and optional via settings.
- Respect reduced-motion preference (shorten or disable animation).

### Standard Timing
- Prayer toggle: 150ms
- Progress update: 250ms
- Screen transitions: 200ms
- Snackbar: 100ms

## 7) Accessibility and RTL
- 4.5:1 contrast minimum for body text.
- Touch targets at least 44x44 (48dp in Flutter).
- Full screen-reader labels and focus order.
- Test Arabic RTL layouts, calendar alignment, and bidi text.

## 8) Performance Targets
- 60 FPS on mid-range Android devices (Snapdragon 665 class).
- App startup under 2 seconds.
- No jank on prayer toggle or calendar navigation.

## 9) Screen Patterns
### Today
- Progress ring + percentage, streak secondary, checklist below.
- Supportive summary line.

### Calendar
- Month grid with complete/partial/not logged states.
- Day detail with edit capability and streak impact notice.

### Settings
- Prayer times, offsets, end-of-day time, theme, language.
- Notifications opt-in toggle, haptics toggle, app lock controls.

### Onboarding
- Short and skippable.
- Request permissions only when relevant (notifications, biometrics).
- Opt-in language for reminders.
- App naming: AR "سجل الصلاة", EN/FR "Salat Tracker".

## 10) Anti-Patterns to Avoid
- Hardcoded colors outside design tokens.
- Confetti or overly celebratory animations.
- Leaderboards or competitive ranking.
- Aggressive or shame-based notifications.
- "Streak broken" messaging.

## 11) QA Checklist (Condensed)
- Design system tokens used everywhere.
- Cairo font applied globally.
- Light/dark parity tested on device.
- RTL layout verified on all screens.
- Notifications opt-in and supportive copy verified.
- Streaks secondary, percentages primary.
- No shame language in UI or notifications.
- 60 FPS target met for core flows.

## Success Metrics (Targets)
- 7-day retention > 60%
- 30-day retention > 40%
- Negative feedback about guilt/shame < 5%
- Accessibility compliance: high contrast and screen reader coverage

---

This guide is the single source for UX, gamification, and psychology alignment. Use it to validate every design and copy decision.