# Phase 04: Local Git Engine

## Objective

Implement offline local Git operations through libgit2/SwiftGit2 behind a single actor boundary.

## Scope

- Repository open/validate.
- Status, log, diff, branch, checkout, commit, stash, merge, rebase, cherry-pick, fetch, pull, and push boundaries.
- Error mapping from libgit2 into user-facing app errors.
- Long-running operation progress and cancellation.

## Implementation Tasks

- Replace sample `GitActor` methods with SwiftGit2-backed operations.
- Define `GitRepositoryHandle` lifecycle and thread-safety rules.
- Add streaming commit history API with initial batch and continuation batches.
- Implement status refresh with file-system event triggers.
- Add test repositories as fixtures for status, branches, merges, conflicts, and history.

## Acceptance Criteria

- Status, recent commits, branches, and diffs work without network access.
- Git operations never block the main actor.
- Conflict and auth-required states surface as structured errors.
- Tests cover successful, conflicted, and invalid-repository cases.

## Existing Skills To Apply

- `ios-architecture-advanced`
- `advanced-testing-strategy`
- `code-safety-scanner`

## Risks

- libgit2 object lifetimes can be fragile if handles escape the actor.
- Git credential helper interactions differ for HTTPS and SSH.
- Large repositories need streaming APIs, not eager loading.
