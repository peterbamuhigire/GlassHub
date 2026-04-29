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

## Next Implementation Pass

1. Add Swift Package Manager dependencies: SwiftGit2, KeychainAccess, MarkdownUI, SnapshotTesting, and Sparkle for direct-download builds.
2. Replace sample commit/status data with `GitActor` calls backed by SwiftGit2/libgit2.
3. Implement GitHub Device Flow in `Core/Auth` and persist tokens in Keychain.
4. Add SwiftData persistence for repository metadata, sidebar ordering, account mapping, and analytics cache.
5. Extend the staging diff view with real hunk and line staging.
