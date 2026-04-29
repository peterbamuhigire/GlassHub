# ADR-003: SwiftGit2/libgit2 Behind A Git Actor

## Status

Accepted

## Context

GlassHub must support full offline local Git workflows. Shelling out to `/usr/bin/git` is convenient but creates parsing, environment, credential, and performance concerns. libgit2 gives programmatic access to repository state and operations, and SwiftGit2 provides Swift wrappers.

## Decision

Use SwiftGit2/libgit2 for local Git operations behind a dedicated actor boundary. All repository handles and libgit2 object lifetimes stay inside `Core/Git`.

The Git actor owns:

- repository open/close
- status
- commit history
- diffs
- staging
- branch operations
- merge/rebase/cherry-pick/stash
- remote operations where libgit2 is appropriate

## Alternatives Considered

- Shell out to Git: useful as a diagnostic fallback, but not the primary engine.
- Implement Git parsing directly: too risky and unnecessary.
- Use GitHub API as source of truth: rejected because offline local Git is core to the product.

## Consequences

- UI and feature view models must call protocols exposed by `Core/Git`.
- Large operations need progress and cancellation.
- Fixture repositories are required for reliable tests.
- libgit2 errors must be mapped into the shared error taxonomy.

## Rollback Path

If SwiftGit2 blocks a specific operation, introduce a narrow fallback adapter for that operation only. The fallback must stay behind the same Git protocol so feature code remains unchanged.
