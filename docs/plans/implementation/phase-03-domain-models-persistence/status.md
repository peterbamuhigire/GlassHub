# Phase 03 Status

## Status

In progress. SwiftData layer is implemented and committed to source. Tests cannot
be executed locally until Phase 02's deferred Xcode test-target attachment is
finished.

## Completed Artifacts

- `GlassHub/Core/Persistence/SchemaV1.swift` — versioned schema namespace and
  `GlassHubMigrationPlan` scaffolding.
- `GlassHub/Core/Persistence/StoredRepository.swift`
- `GlassHub/Core/Persistence/StoredRepositoryGroup.swift`
- `GlassHub/Core/Persistence/StoredAccountReference.swift` — Keychain pointer only;
  no secret material.
- `GlassHub/Core/Persistence/StoredCommitCache.swift`
- `GlassHub/Core/Persistence/StoredAnalyticsSnapshot.swift`
- `GlassHub/Core/Persistence/StoredPreference.swift`
- `GlassHub/Core/Persistence/PersistenceTypeAliases.swift` — flattens
  `SchemaV1.StoredX` to `StoredX` for app callers.
- `GlassHub/Core/Persistence/PersistenceController.swift` — `ModelContainer`
  factory with `inMemory()` and `temporary(url:)` variants.
- `GlassHub/Core/Persistence/PersistenceActor.swift` — `@ModelActor` for
  off-main writes; ships with `upsertRepository` and `invalidateCaches` entry
  points.
- `GlassHub/Core/Persistence/PersistenceDebugTools.swift` — JSON snapshot
  export/decode for inspection; intentionally omits `keychainAccount`.
- `GlassHubTests/Persistence/PersistenceRoundTripTests.swift`
- `GlassHubTests/Persistence/SchemaV1MigrationTests.swift`
- `GlassHubTests/Persistence/PersistenceSecretLeakTests.swift`

## Architectural Notes

- All `@Model` classes are declared inside `extension SchemaV1`. This keeps the
  schema versioned-namespace clean and matches the SwiftData migration pattern
  recommended for evolving stores.
- `ModelContext` is not `Sendable`, so `PersistenceActor` is the only writer
  outside the main actor. Other code must dispatch writes through `actor.perform`.
- Token storage stays in Keychain. `StoredAccountReference` only carries a
  `keychainAccount` lookup string. The secret-leak test verifies the JSON
  snapshot never emits known token field names.
- `SchemaV1` is the inaugural version; `GlassHubMigrationPlan.stages` is empty.
  Stages will be added when V2 ships, with a corresponding V1→V2 test.

## Acceptance Criteria Review

| Criterion | Status | Evidence |
|---|---|---|
| Repository sidebar state survives app relaunch | Code complete; awaiting Xcode-run verification | `PersistenceRoundTripTests.testRepositorySurvivesContextReload` |
| Cached commit and analytics data can be invalidated per repository | Code complete; awaiting Xcode-run verification | `PersistenceActor.invalidateCaches`, `PersistenceRoundTripTests.testInvalidatingCachesDeletesCommitsAndAnalytics` |
| Schema migrations are covered by tests before production data exists | Code complete; awaiting Xcode-run verification | `SchemaV1MigrationTests.testSeededV1StoreOpensThroughMigrationPlan` |
| No OAuth token or secret appears in SwiftData files | Code complete; awaiting Xcode-run verification | `StoredAccountReference` field set + `PersistenceSecretLeakTests` |

## Deferred In Full Xcode

- Run `xcodebuild test` against `GlassHubTests` once test target is attached
  (Phase 02 deferral).
- Bind a `PersistenceController.shared.container` into the SwiftUI environment
  in `GlassHubApp` once UI consumers (Phase 05) need it. Left out for now to
  keep the persistence layer dormant on first launch.

## Blocker

None new. Inherits Phase 02's blocker: full Xcode is required to build and run
tests; only Command Line Tools are active locally.
