# Build Configurations

GlassHub uses four intended build configurations.

## Debug

Local development with testability and no optimization.

## Beta

Release-like beta build with beta-only compilation condition.

## Release-AppStore

Mac App Store build.

Rules:

- Sandbox enabled.
- Hardened runtime enabled.
- Sparkle excluded.
- Privacy labels and review notes must match behavior.

## Release-Direct

Direct-download build.

Rules:

- Sandbox should remain enabled unless a documented exception is approved.
- Hardened runtime enabled.
- Notarization required.
- Sparkle may be linked for auto-update.

## Release Evidence

Every release candidate should record:

- Git commit SHA.
- Xcode version.
- Build configuration.
- Test command and result.
- Archive/export method.
- Known skipped checks.
