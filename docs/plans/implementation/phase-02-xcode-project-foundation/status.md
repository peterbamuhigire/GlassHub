# Phase 02 Status

## Status

In progress. The repository foundation is scaffolded; final package resolution and test-target attachment should be completed in full Xcode.

## Completed Artifacts

- `Configs/Base.xcconfig`
- `Configs/Debug.xcconfig`
- `Configs/Beta.xcconfig`
- `Configs/Release-AppStore.xcconfig`
- `Configs/Release-Direct.xcconfig`
- `GlassHub/Resources/GlassHub.entitlements`
- `GlassHub/Resources/PrivacyInfo.xcprivacy`
- `GlassHubTests/`
- `GlassHubUITests/`
- `GlassHubSnapshotTests/`
- [Xcode setup guide](../../../development/xcode-setup.md)
- [Package dependency plan](../../../development/package-dependencies.md)
- [Build configuration guide](../../../release/build-configurations.md)
- `scripts/build.sh`
- `scripts/test.sh`

## Project Updates

- Bundle identifier set to `com.byoosi.glasshub`.
- macOS deployment target remains `14.0`.
- App target points at `GlassHub/Resources/GlassHub.entitlements`.
- User-selected file access is read/write for repository workflows.
- Outgoing network client access is enabled.
- Build configurations added to the Xcode project: `Beta`, `Release-AppStore`, and `Release-Direct`.
- `Release-AppStore` sets `GLASSHUB_ENABLE_SPARKLE = NO`.
- `Release-Direct` sets `GLASSHUB_ENABLE_SPARKLE = YES`.

## Acceptance Criteria Review

| Criterion | Status | Evidence |
|---|---|---|
| Clean checkout builds in Xcode | Pending full Xcode verification | Command Line Tools are active locally |
| Tests can run from Xcode and command line | Partially complete | Test source scaffolds exist; targets need Xcode attachment |
| App Store and direct-download builds can diverge only where required | Complete at configuration level | `Release-AppStore` / `Release-Direct` settings |
| Entitlements are explicit and documented | Complete | entitlements file and setup docs |

## Deferred In Full Xcode

- Attach `GlassHubTests`, `GlassHubUITests`, and `GlassHubSnapshotTests` as Xcode targets.
- Add SPM packages through Xcode Package Dependencies.
- Link `SnapshotTesting` only to the snapshot test target.
- Link `Sparkle` only to the direct-download build path.
- Run `xcodebuild build` and `xcodebuild test` with full Xcode selected.

## Blocker

This machine currently has Command Line Tools selected. `xcodebuild` requires full Xcode for project build and package resolution.
