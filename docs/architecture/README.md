# GlassHub Architecture

This directory records the product architecture decisions that guide implementation. It is the stable reference for module ownership, dependency boundaries, data refresh rules, and high-risk technical choices.

## Architecture Principles

- Local Git state is the source of truth for local repository workflows.
- GitHub state augments collaboration workflows and must never be required for offline Git operations.
- SwiftUI owns primary UI composition; AppKit is used only for platform capabilities SwiftUI does not cover well.
- Long-running work is isolated behind actors and never blocks the main actor.
- Credentials are stored only in Keychain.
- Sandbox and file-access constraints are product requirements, not late release checks.

## Document Map

| Document | Purpose |
|---|---|
| [module-boundaries.md](module-boundaries.md) | Ownership map for app modules and feature folders |
| [dependency-scopes.md](dependency-scopes.md) | Dependency container scopes and lifetime rules |
| [error-taxonomy.md](error-taxonomy.md) | Shared error categories and UI handling expectations |
| [data-refresh-rules.md](data-refresh-rules.md) | Local Git, GitHub, cache, and analytics refresh rules |
| [adr/](adr/) | Architecture Decision Records |

## ADR Index

| ADR | Decision |
|---|---|
| [ADR-001](adr/ADR-001-swiftui-appkit-split.md) | SwiftUI-first UI with targeted AppKit bridges |
| [ADR-002](adr/ADR-002-swiftdata-local-persistence.md) | SwiftData for app metadata and caches |
| [ADR-003](adr/ADR-003-swiftgit2-libgit2-local-git.md) | SwiftGit2/libgit2 behind a Git actor |
| [ADR-004](adr/ADR-004-github-oauth-device-flow.md) | GitHub OAuth Device Flow with Keychain tokens |
| [ADR-005](adr/ADR-005-sandbox-file-access.md) | Sandbox-aware repository access using user consent |

## Phase 01 Completion Criteria

- Major module ownership is documented.
- High-risk architecture decisions have ADRs.
- Local Git and GitHub remote state have clear separation.
- Later phases can use these docs as constraints when adding code.
