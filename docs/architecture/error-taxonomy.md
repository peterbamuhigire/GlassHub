# Error Taxonomy

Errors must be structured before they reach the UI. The UI should never parse libgit2 messages, URLSession errors, Keychain status codes, or SwiftData exceptions directly.

## Error Categories

| Category | Source | User Handling |
|---|---|---|
| Git | libgit2/SwiftGit2, local repository state | Show operation-specific recovery action |
| Auth | OAuth, Keychain, account state | Prompt sign-in, retry, or account repair |
| GitHub API | REST/GraphQL, rate limits, server errors | Show remote-only degraded state |
| Sandbox/File Access | security-scoped bookmarks, permissions, missing files | Ask user to re-grant access or locate repo |
| Persistence | SwiftData, migrations, cache corruption | Recover cache, reset derived data, preserve user choices |
| Search/Indexing | fuzzy index, Spotlight | Degrade search/indexing without blocking core Git |
| Analytics | aggregation, cache staleness | Recompute or show partial data |
| App/Unknown | unexpected state | Log sanitized diagnostics and offer retry |

## Git Errors

| Error | Meaning | Recovery |
|---|---|---|
| `repositoryNotFound` | Path is missing or not a Git repo | Remove from GlassHub or locate folder |
| `worktreeDirty` | Operation requires clean working tree | Commit, stash, or discard changes |
| `conflictDetected` | Merge/rebase/cherry-pick produced conflicts | Open conflict resolver |
| `detachedHead` | Current HEAD is not a branch | Create branch or continue read-only |
| `remoteAuthRequired` | Remote operation needs credentials | Choose account or configure SSH/HTTPS |
| `operationCancelled` | User cancelled long-running Git task | No error alert; keep prior state |

## Auth Errors

| Error | Meaning | Recovery |
|---|---|---|
| `deviceCodeExpired` | OAuth device code timed out | Restart sign-in |
| `accessDenied` | User denied OAuth request | Keep account signed out |
| `tokenMissing` | Keychain item not found | Re-authenticate |
| `tokenRevoked` | GitHub rejected stored token | Re-authenticate |
| `enterpriseHostInvalid` | Enterprise URL is not supported/reachable | Edit host URL |

## GitHub API Errors

| Error | Meaning | Recovery |
|---|---|---|
| `rateLimited` | API quota exhausted | Show reset time and pause sync |
| `notFound` | Repo/PR/resource unavailable | Check account or repo access |
| `graphqlPartialFailure` | Some GraphQL fields failed | Show partial PR data |
| `networkUnavailable` | No network path | Continue local-only |
| `serverUnavailable` | GitHub/Enterprise server failed | Retry later |

## Sandbox And File Access Errors

| Error | Meaning | Recovery |
|---|---|---|
| `bookmarkStale` | Security-scoped bookmark needs refresh | Ask user to reselect folder |
| `permissionDenied` | Sandbox cannot access path | Ask user to grant access |
| `pathMoved` | Repository path changed | Locate repository |
| `externalMutation` | Repo changed during operation | Refresh status and retry if safe |

## UI Rules

- Alerts must name the failed operation.
- Destructive recovery actions require explicit confirmation.
- Offline and rate-limit states are degraded states, not fatal app errors.
- Logs must not contain OAuth tokens, private diff contents, or full remote URLs with credentials.
