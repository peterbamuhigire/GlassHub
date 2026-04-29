# Phase 01: Product Architecture

## Status

Completed for initial implementation planning. See [status.md](status.md).

## Objective

Turn the product specification into implementation architecture that is specific enough to guide code, tests, and future tradeoffs.

## Scope

- Define final module boundaries for `App`, `Core`, `Features`, and `UI`.
- Decide dependency ownership for Git, GitHub API, auth, persistence, analytics, and macOS services.
- Create Architecture Decision Records for major choices.
- Document the offline-first rule: local Git is the source of truth for repository state; GitHub augments remote collaboration state.

## Implementation Tasks

- Create `docs/architecture/` with ADRs for SwiftUI/AppKit split, SwiftData, SwiftGit2/libgit2, OAuth device flow, and sandbox strategy.
- Define dependency container scopes: app, account, repository, feature, interaction.
- Define error taxonomy for Git errors, auth errors, network errors, sandbox access errors, and persistence errors.
- Define feature ownership map so every future file has an obvious home.
- Decide data refresh rules for repository status, GitHub metadata, commit cache, and analytics cache.

## Acceptance Criteria

- Architecture docs identify the owner module for every major product capability.
- All high-risk choices have an ADR with decision, alternatives, consequences, and rollback path.
- The plan clearly separates local Git state from GitHub remote state.
- Future phases can reference stable boundaries rather than inventing them mid-build.

## Existing Skills To Apply

- `feature-planning`
- `doc-architect`
- `ios-architecture-advanced`

## Risks

- Over-abstracting before libgit2 behavior is proven.
- Mixing account, repository, and global state too early.
- Treating GitHub as required for local workflows.
