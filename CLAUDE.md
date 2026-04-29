# GlassHub — Agent Instructions

GlassHub is a native macOS GitHub client built with Swift, SwiftUI, and SwiftData.
This file is read at the start of every Claude Code session in this repository.
Treat its contents as binding project conventions.

## Source of Truth

- Product spec: `docs/plans/implementation/README.md`
- Phase plans + status: `docs/plans/implementation/phase-*/`
- Architecture: `docs/architecture/` (module boundaries, data refresh rules,
  error taxonomy, dependency scopes, ADRs)
- Build/test: `docs/development/xcode-setup.md`,
  `docs/release/build-configurations.md`
- Always check the relevant `phase-*/status.md` before starting work in that
  phase — it tracks what landed and what is deferred.

## Tech and Targets

- Bundle id: `com.chwezicore.glasshub` (Chwezi Core Systems)
- macOS deployment target: `14.0` (SwiftData, `@Observable`, `@ModelActor`
  available — use them)
- Build configurations: `Debug`, `Beta`, `Release-AppStore`,
  `Release-Direct`. `GLASSHUB_ENABLE_SPARKLE` is `YES` only for `Release-Direct`.
- Project uses Xcode 16's `PBXFileSystemSynchronizedRootGroup` for the
  `GlassHub/` group — new files dropped under it are picked up by the app
  target automatically. **Do not hand-edit `project.pbxproj` for source
  additions inside `GlassHub/`.**
- Test targets (`GlassHubTests`, `GlassHubUITests`, `GlassHubSnapshotTests`)
  are not yet attached as Xcode targets (Phase 02 deferral). Tests can be
  written but cannot be executed locally until the user opens full Xcode and
  attaches them.

## Module Boundaries

Enforced by `docs/architecture/module-boundaries.md`. Quick reminders:

- `App -> Features -> Core`, plus `App -> UI` and `Features -> UI`.
- `Core` modules must not import `Features` or `UI`.
- `Core/Git` and `Core/GitHub` must not depend on each other.
- `Core/Persistence` stores cache metadata. It is **never** the source of truth
  for live repository status, and must **never** store tokens or secrets.

## Persistence Conventions (Phase 03)

- All `@Model` classes live inside `extension SchemaV1` in
  `GlassHub/Core/Persistence/`. Top-level `typealias`es expose them as
  `StoredX` to the rest of the app.
- New stored types: add them to `SchemaV1.models` and create a
  `typealias` in `PersistenceTypeAliases.swift`.
- Schema evolution: never mutate `SchemaV1` after data ships. Create
  `SchemaV2`, append it to `GlassHubMigrationPlan.schemas`, add a
  `MigrationStage` and a paired V1→V2 test before merging.
- `ModelContext` is not `Sendable`. Off-main writes go through
  `PersistenceActor` (or a new `@ModelActor`). Do not pass `ModelContext`
  across actor boundaries.
- Tokens, refresh tokens, passwords, and client secrets must never be added
  as `@Model` properties. The secret-leak test
  (`PersistenceSecretLeakTests`) enforces this — extend it when adding new
  account-shaped types.

## Skills

- The user's global skills library lives at `/Users/Apple/Sites/skills-web-dev/`.
  Apply `ios-development`, `ios-tdd`, `swiftui-design`, and
  `ios-data-persistence` skills when working on this project. Load
  `vibe-security-skill` for any auth or secret-handling change.
- Use `superpowers:executing-plans` (or `subagent-driven-development` if
  available) when working through a phase plan.

## Workflow Defaults

- Branch policy: the user works directly on `main` and commits per phase.
  Do not create feature branches without asking. Do not commit unless
  explicitly asked.
- When a phase is done, always write or update its `status.md` documenting
  completed artifacts, deferred items, acceptance-criteria evidence, and
  any blockers — match the format used in
  `phase-02-xcode-project-foundation/status.md`.
- `xcodebuild` cannot run locally until the machine has full Xcode selected.
  If an action requires a live build or test run, write the code, document the
  verification gap in `status.md`, and surface it to the user rather than
  claiming success.

## Style

- Swift: prefer `struct` + value types for domain models, `actor` for
  concurrency boundaries, `@Observable` (Swift 5.9+) for view models,
  SwiftUI for new views. AppKit only when SwiftUI cannot reach the
  required macOS API.
- Keep comments terse and load-bearing; never narrate what the code does.
  Document non-obvious invariants (e.g., why a model lives in
  `extension SchemaV1`) inline.
- Match existing file headers and structure when adding new files in a
  directory.
