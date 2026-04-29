# ADR-004: GitHub OAuth Device Flow With Keychain Tokens

## Status

Accepted

## Context

GlassHub needs multi-account GitHub support for github.com and GitHub Enterprise Server. A native macOS app should avoid fragile redirect handling where possible. GitHub OAuth Device Flow gives a browser-assisted but app-friendly sign-in path.

## Decision

Use GitHub OAuth Device Flow for sign-in. Store access tokens only in macOS Keychain. Persist only account metadata and Keychain lookup references in SwiftData.

Auth architecture:

- `Core/Auth` owns device-code requests, polling, token storage, token removal, and account metadata.
- `Core/GitHub` receives token access through an account-scoped dependency.
- UI never stores or logs raw tokens.

## Alternatives Considered

- Personal access token paste-in: useful for advanced fallback, but poor primary UX and easier to mishandle.
- Browser redirect OAuth: common, but more setup and callback complexity for this product.
- Git credential helper only: insufficient for GitHub API, PRs, reviews, and notifications.

## Consequences

- Sign-in UI must handle polling, timeout, cancellation, and denial.
- Keychain access must be validated under App Store signing.
- GitHub Enterprise Server support needs host configuration and capability checks.
- Review notes must explain the OAuth flow for App Store testers.

## Rollback Path

If Device Flow is unavailable for a target host, add a scoped manual token fallback for that host. The fallback must use the same Keychain storage and account model.
