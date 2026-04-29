# Phase 03: Domain Models And Persistence

## Objective

Build the SwiftData persistence foundation for repositories, accounts, preferences, cached commits, analytics snapshots, and sidebar organization.

## Scope

- Define value models for app logic and SwiftData models for persistence.
- Implement repository metadata storage.
- Persist groups, ordering, recent repositories, selected account per repository, and user preferences.
- Create migration strategy from the first schema version.

## Implementation Tasks

- Add SwiftData models for `StoredRepository`, `StoredRepositoryGroup`, `StoredAccountReference`, `StoredCommitCache`, `StoredAnalyticsSnapshot`, and `StoredPreference`.
- Keep credentials out of SwiftData; store only Keychain lookup references.
- Add a persistence actor for background writes and cache refreshes.
- Add import/export debug tools for persistence inspection.
- Add migration tests with seeded v1 stores.

## Acceptance Criteria

- Repository sidebar state survives app relaunch.
- Cached commit and analytics data can be invalidated per repository.
- Schema migrations are covered by tests before any production data exists.
- No OAuth token or secret appears in SwiftData files.

## Existing Skills To Apply

- `ios-swiftdata`
- `ios-data-persistence`
- `advanced-testing-strategy`

## Risks

- SwiftData `ModelContext` is not Sendable; background work must use proper actor boundaries.
- Cache invalidation can become inconsistent if local Git and GitHub sync write the same records.
- Over-persisting derived data can make migrations harder than recomputation.
