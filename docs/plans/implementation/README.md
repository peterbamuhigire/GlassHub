# GlassHub Implementation Plan

This directory breaks GlassHub into 17 implementation phases. Phases 1-16 build the product from architecture through release hardening. Phase 17 covers publishing the macOS app to the App Store.

## Skill Inputs Studied

The plan is informed by these existing skills from `/Users/Apple/Sites/skills-web-dev`:

- `doc-architect`: keep planning modular, indexed, and under reviewable document sizes.
- `feature-planning`: define acceptance criteria, implementation paths, and TDD workflow per phase.
- `swiftui-design` and `swiftui-pro-patterns`: apply SwiftUI layout, identity, performance, and visual-quality rules.
- `ios-architecture-advanced`: adapt scoped dependency containers, MVVM, and unidirectional data flow to macOS.
- `ios-swiftdata`: use SwiftData schema, migration, testing, and ModelActor guidance for local persistence.
- `data-visualization`: keep analytics charts clear, uncluttered, and decision-oriented.
- `advanced-testing-strategy`: map tests to failure modes and release risk.
- `cicd-pipeline-design` and `deployment-release-engineering`: build once, promote safely, and retain release evidence.
- `app-store-review`: adapt App Store metadata, privacy, entitlement, review-note, and TestFlight readiness practices to macOS.

## Phase Index

| Phase | Directory | Outcome |
|---|---|---|
| 01 | `phase-01-product-architecture` | Product architecture, module boundaries, ADRs |
| 02 | `phase-02-xcode-project-foundation` | Xcode project, targets, entitlements, packages |
| 03 | `phase-03-domain-models-persistence` | SwiftData schema and persistence layer |
| 04 | `phase-04-local-git-engine` | libgit2/SwiftGit2 local Git actor |
| 05 | `phase-05-repository-management` | Discovery, add, clone, grouping, sidebar |
| 06 | `phase-06-auth-keychain-accounts` | GitHub accounts, OAuth device flow, Keychain |
| 07 | `phase-07-github-api-integration` | REST/GraphQL API client and sync |
| 08 | `phase-08-commit-history-graph` | Commit timeline, graph renderer, filters |
| 09 | `phase-09-diff-viewer-staging` | Diff viewer, staging, hunk/line staging |
| 10 | `phase-10-branch-merge-workflows` | Branch, merge, rebase, stash, cherry-pick |
| 11 | `phase-11-pull-requests-code-review` | PR list/detail/review/create workflows |
| 12 | `phase-12-analytics-dashboard` | Charts, churn, heatmap, contributors |
| 13 | `phase-13-command-palette-search` | Command palette and fuzzy search index |
| 14 | `phase-14-macos-integrations` | Spotlight, Quick Look, notifications, menu bar |
| 15 | `phase-15-quality-testing-ci` | Test suite, snapshots, CI/CD pipeline |
| 16 | `phase-16-beta-release-hardening` | Performance, accessibility, notarized beta |
| 17 | `phase-17-app-store-publishing` | App Store Connect release |

## Cross-Phase Rules

- Keep Git operations offline-first and actor-isolated.
- Keep GitHub API operations separate from local Git operations.
- Store credentials only in Keychain.
- Treat sandboxing and file access as first-class design constraints.
- Use SwiftUI first, AppKit only where required.
- Every phase must leave the app buildable.
