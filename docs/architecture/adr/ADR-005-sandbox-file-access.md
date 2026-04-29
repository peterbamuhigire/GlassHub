# ADR-005: Sandbox-Aware Repository Access

## Status

Accepted

## Context

GlassHub is intended for Mac App Store distribution. The app needs access to local repositories across the user's filesystem, but sandboxed apps cannot freely scan and mutate arbitrary folders without user consent.

## Decision

Design repository access around explicit user consent, security-scoped bookmarks, and clear sandbox behavior. Automatic discovery can suggest likely paths, but durable repository access must be user-approved where sandbox rules require it.

Repository access rules:

- Manual add and clone destination selection use user-granted folder access.
- Persist security-scoped bookmarks for added repositories.
- Refresh stale bookmarks through a user-facing repair flow.
- Keep direct-download behavior close to App Store behavior unless a documented build difference is required.

## Alternatives Considered

- Disable sandbox for all builds: rejected because Mac App Store publishing is a product goal.
- Require users to store repos in one app-managed folder: simpler, but fails the "every repo on your Mac" vision.
- Full-disk access prompts: too broad and likely poor for review/user trust.

## Consequences

- Repository discovery must be conservative and permission-aware.
- File access errors become first-class UI states.
- Tests need sandbox and bookmark scenarios where possible.
- App Store review notes must explain local repository access clearly.

## Rollback Path

If a specific integration cannot work under sandbox, keep it out of the App Store build or ship it as a documented direct-download-only capability. Core repository workflows must remain App Store-compatible.
