# Phase 02: Xcode Project Foundation

## Status

In progress. See [status.md](status.md).

## Objective

Convert the starter app into a production-ready Xcode foundation with correct targets, build settings, signing posture, entitlements, dependencies, and development workflow.

## Scope

- Normalize deployment target to macOS 14+.
- Add app, unit test, UI test, and snapshot test targets.
- Add Swift Package Manager dependencies.
- Configure sandbox, hardened runtime, file access, Keychain, network, and future app group entitlements.
- Establish build schemes for Debug, Beta, App Store, and Direct Download.

## Implementation Tasks

- Add packages: SwiftGit2, KeychainAccess, MarkdownUI, SnapshotTesting, Sparkle for direct distribution only.
- Create `GlassHubTests`, `GlassHubUITests`, and `GlassHubSnapshotTests`.
- Define `Debug`, `Beta`, `Release-AppStore`, and `Release-Direct` configurations.
- Add `.xcconfig` files for shared build settings.
- Document local setup in `docs/development/xcode-setup.md`.
- Add app icon, accent color, and baseline bundle metadata.

## Acceptance Criteria

- A clean checkout builds in Xcode.
- Tests can run from Xcode and command line.
- App Store and direct-download builds can diverge only where required.
- Entitlements are explicit and documented.

## Existing Skills To Apply

- `ios-project-setup`
- `cicd-pipeline-design`
- `deployment-release-engineering`

## Risks

- Sparkle is not allowed in the Mac App Store build.
- Sandbox file access can break repository discovery unless planned from the beginning.
- Xcode file-system-synchronized groups may hide project membership mistakes.
