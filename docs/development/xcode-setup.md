# Xcode Setup

## Requirements

- macOS 14 Sonoma or later.
- Xcode 16 or later.
- Full Xcode selected for command-line tools.

## Select Xcode

```sh
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

## Open Project

```sh
open GlassHub.xcodeproj
```

## Build

```sh
xcodebuild -project GlassHub.xcodeproj -scheme GlassHub -destination 'platform=macOS' build
```

## Test

After Phase 02 test targets are attached in Xcode, run:

```sh
xcodebuild -project GlassHub.xcodeproj -scheme GlassHub -destination 'platform=macOS' test
```

## Configurations

| Configuration | Purpose |
|---|---|
| Debug | Local development |
| Beta | Signed beta candidate |
| Release-AppStore | Mac App Store build |
| Release-Direct | Notarized direct-download build |

## Entitlements

Entitlements live in `GlassHub/Resources/GlassHub.entitlements`.

- App Sandbox is enabled.
- User-selected file read/write is enabled for repositories.
- Outgoing network client access is enabled for GitHub and Git remotes.
- Keychain access group is scoped to the app bundle identifier.

## Notes

- `Sparkle` must only be linked for `Release-Direct`.
- OAuth tokens must remain in Keychain.
- App Store file access behavior must remain user-consent based.
