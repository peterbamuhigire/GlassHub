# Phase 06: Auth, Keychain, And Accounts

## Objective

Implement secure multi-account GitHub authentication for github.com and GitHub Enterprise Server.

## Scope

- GitHub OAuth device flow.
- Token storage in macOS Keychain.
- Multiple accounts and repository-account mapping.
- Token refresh, revocation, and account removal.
- Credential selection for GitHub API and Git operations.

## Implementation Tasks

- Build `AuthActor` with device-code request, polling, timeout, and cancellation.
- Store access tokens in KeychainAccess with service/account grouping.
- Persist non-secret account metadata in SwiftData.
- Add Settings account UI: add, remove, set default, test connection.
- Add GitHub Enterprise host support with per-host validation.
- Add audit tests ensuring secrets never hit logs or SwiftData.

## Acceptance Criteria

- Users can sign in to multiple GitHub accounts.
- Tokens survive relaunch and can be removed cleanly.
- Repository API requests use the mapped account automatically.
- No token appears in app logs, crash logs, SwiftData, or plain files.

## Existing Skills To Apply

- `ios-app-security`
- `ios-networking-advanced`
- `advanced-testing-strategy`

## Risks

- Device-flow polling must respect GitHub rate and interval responses.
- GitHub Enterprise versions may differ in endpoint behavior.
- Keychain access groups must be correct for App Store signing.
