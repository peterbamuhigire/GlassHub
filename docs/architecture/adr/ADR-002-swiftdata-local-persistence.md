# ADR-002: SwiftData For Local Persistence

## Status

Accepted

## Context

GlassHub needs to persist repository metadata, sidebar order, account mappings, cached commit summaries, analytics caches, and preferences. The target platform is macOS 14+, so SwiftData is available and aligns with SwiftUI and the Observation framework.

## Decision

Use SwiftData for non-secret local app data and derived caches. Use Keychain for secrets. Do not use SQLite directly or Core Data directly unless SwiftData blocks a required migration or performance path.

SwiftData owns:

- repository records
- repository groups and ordering
- recent repositories
- account references without tokens
- commit cache summaries
- analytics snapshots
- user preferences

SwiftData does not own:

- OAuth access tokens
- live working tree status as source of truth
- raw large diffs
- private file contents

## Alternatives Considered

- Core Data directly: mature and powerful, but more boilerplate than needed for the first macOS 14+ version.
- SQLite directly: maximum control, but higher migration and model-maintenance cost.
- JSON files: simple initially, but weak for relationships, migration, and query needs.

## Consequences

- Schema migration planning starts from version 1.
- Background work must respect `ModelContext` isolation.
- Derived caches must be disposable and recomputable.
- Tests need seeded stores for migration and cache behavior.

## Rollback Path

If SwiftData proves unsuitable for a specific high-volume cache, move that cache behind a repository protocol and use a dedicated store. Keep user preferences and repository metadata on SwiftData unless a migration blocker appears.
