# GlassHub

GlassHub is a native macOS GitHub repository manager by Chwezi / Byoosi.com Ltd. It is built with Xcode, Swift, SwiftUI, and AppKit integration points where native macOS APIs are needed.

This repository has been kickstarted as a runnable macOS SwiftUI app shell that follows the product specification:

- `NavigationSplitView` single-window layout with repository sidebar, workspace, and inspector.
- Repository discovery service that scans common local folders for `.git` directories.
- Starter feature modules for repositories, commits, staging, branches, pull requests, analytics, command palette, and menu bar status.
- Seed models and sample data for building UI while libgit2/GitHub API work is wired in.
- Swift Charts analytics dashboard prototype for commit frequency, churn, language breakdown, and contribution heatmap.

## Project Structure

```text
GlassHub/
├── App/                     # AppState and app command definitions
├── Core/
│   ├── Auth/                # Account/token boundary
│   ├── Git/                 # Local repository scanner and Git actor boundary
│   ├── GitHub/              # GitHub API client boundary
│   ├── Models/              # Sendable app models and sample data
│   ├── Persistence/         # SwiftData schema, migration plan, persistence actor
│   └── Search/              # Fuzzy matching
├── Features/
│   ├── Analytics/
│   ├── Branches/
│   ├── CommandPalette/
│   ├── Commits/
│   ├── MenuBarExtra/
│   ├── PullRequests/
│   ├── Repositories/
│   └── Staging/
└── UI/
    ├── Components/
    └── Theme/
```

## Development

Open the app in Xcode:

```sh
open GlassHub.xcodeproj
```

Build from the command line when full Xcode is selected:

```sh
xcodebuild -project GlassHub.xcodeproj -scheme GlassHub -destination 'platform=macOS' build
```

If `xcodebuild` reports that Command Line Tools are selected, point the machine at full Xcode first:

```sh
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

## Implementation Plan

The work is staged across phases under [`docs/plans/implementation/`](docs/plans/implementation).
Status of each phase:

- **Phase 01 — Product architecture:** complete.
- **Phase 02 — Xcode project foundation:** in progress (test targets and SPM
  packages must be attached in full Xcode). See
  [phase-02 status](docs/plans/implementation/phase-02-xcode-project-foundation/status.md).
- **Phase 03 — Domain models and persistence:** SwiftData layer landed in
  `Core/Persistence/`; tests committed but not yet runnable until Phase 02
  closes. See
  [phase-03 status](docs/plans/implementation/phase-03-domain-models-persistence/status.md).
- **Phase 04+ — Local Git engine, auth, GitHub API, history, staging, branches,
  pull requests, analytics, command palette, macOS integrations, QA, beta,
  release:** queued.

## Next Implementation Pass

1. Open the project in full Xcode and finish Phase 02 — attach
   `GlassHubTests`, `GlassHubUITests`, and `GlassHubSnapshotTests` as targets
   and add SPM packages (SwiftGit2, KeychainAccess, MarkdownUI, SnapshotTesting,
   Sparkle for direct-download).
2. Run the new persistence test suite under
   `GlassHubTests/Persistence/` and close out Phase 03 acceptance criteria.
3. Phase 04 — replace sample commit/status data with `GitActor` calls backed by
   SwiftGit2/libgit2 and persist results through `PersistenceActor`.
4. Phase 06 — implement GitHub Device Flow in `Core/Auth` and store tokens in
   Keychain (referenced by `StoredAccountReference.keychainAccount`).
5. Phase 09 — extend the staging diff view with real hunk and line staging.
