# Phase 16: Beta Release Hardening

## Objective

Prepare GlassHub for external beta use through performance, accessibility, crash safety, signing, notarization, documentation, and feedback loops.

## Scope

- Instruments profiling for launch, memory, scrolling, diff rendering, and analytics.
- Accessibility and keyboard navigation audit.
- Crash and diagnostic logging strategy.
- Direct-download notarized DMG build.
- TestFlight beta readiness if using App Store Connect beta.
- User manual and support docs.

## Implementation Tasks

- Define performance budgets: launch time, idle memory, commit-list scroll, large diff open.
- Run Instruments profiles and record evidence.
- Audit VoiceOver labels, keyboard focus, contrast, and Dynamic Type where applicable.
- Add crash-reporting policy consistent with privacy claims.
- Configure notarization and DMG packaging for direct beta.
- Add feedback link and diagnostic export that excludes secrets.

## Acceptance Criteria

- Beta build is signed, hardened, and notarized.
- Performance budgets are measured and documented.
- Accessibility audit has no blocking issues.
- Support docs explain permissions, repository access, auth, and privacy.

## Existing Skills To Apply

- `deployment-release-engineering`
- `advanced-testing-strategy`
- `app-store-review`
- `design-audit`

## Risks

- Diagnostics can accidentally include repository paths or private commit data.
- Direct distribution and App Store distribution have different update and entitlement constraints.
- Performance work must be measured, not guessed.
