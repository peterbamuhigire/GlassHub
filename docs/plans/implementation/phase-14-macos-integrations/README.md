# Phase 14: macOS Integrations

## Objective

Implement the native macOS capabilities that make GlassHub feel like a real Mac app.

## Scope

- Spotlight indexing for repositories and commits.
- Quick Look previews for image, binary, and document changes.
- Notification Center for sync, PR, CI, and review events.
- Menu bar extra with branch and sync status.
- Share Sheet for commit and PR links.
- Handoff-ready `NSUserActivity`.
- Finder badges or File Provider extension investigation.

## Implementation Tasks

- Add CoreSpotlight indexing service with privacy controls.
- Add Quick Look wrapper and preview routing.
- Add UserNotifications categories and actionable notification handlers.
- Expand menu bar extra into push/pull/fetch quick actions.
- Add ShareLink for commit URLs and PR URLs.
- Add `NSUserActivity` metadata for repo and commit views.
- Research Finder badge feasibility under sandbox and App Store rules.

## Acceptance Criteria

- Spotlight can open GlassHub directly to indexed repos/commits.
- Quick Look handles supported files without custom rendering.
- Notifications are useful, rate-limited, and configurable.
- Menu bar state reflects the selected or pinned repository.

## Existing Skills To Apply

- `swiftui-design`
- `ios-push-notifications`
- `app-store-review`

## Risks

- Some integrations require entitlements or extensions that complicate App Store review.
- Spotlight indexing must not leak private repository data without user control.
- Notifications can become noisy if not throttled.
