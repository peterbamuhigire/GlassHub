# Package Dependencies

Phase 02 defines the package set and linking rules. Add these through Xcode Package Dependencies when full Xcode is active.

| Package | URL | Product | Link In |
|---|---|---|---|
| SwiftGit2 | `https://github.com/SwiftGit2/SwiftGit2` | `SwiftGit2` | App, tests |
| KeychainAccess | `https://github.com/kishikawakatsuki/KeychainAccess` | `KeychainAccess` | App, tests |
| MarkdownUI | `https://github.com/gonzalezreal/swift-markdown-ui` | `MarkdownUI` | App |
| Highlightr | `https://github.com/raspu/Highlightr` | `Highlightr` | App |
| SnapshotTesting | `https://github.com/pointfreeco/swift-snapshot-testing` | `SnapshotTesting` | Snapshot tests only |
| Sparkle | `https://github.com/sparkle-project/Sparkle` | `Sparkle` | `Release-Direct` only |

## Rules

- Do not link Sparkle into `Release-AppStore`.
- Keep package additions in the Xcode project, not CocoaPods or Carthage.
- Record version pins in this document once the packages are attached.
- Re-run App Store entitlement and dependency review after adding any package.

## Deferred Until Full Xcode Is Active

The current shell has Command Line Tools selected, not full Xcode. Package resolution and target linking should be completed in Xcode so the generated project file remains valid.
