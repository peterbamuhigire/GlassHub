# Data Refresh Rules

GlassHub has four state sources: local Git, GitHub remote metadata, persistence caches, and derived analytics. Each source has different freshness and offline requirements.

## Source Of Truth

| Data | Source Of Truth | Cached In SwiftData | Offline Required |
|---|---|---:|---:|
| Current branch | local Git | yes | yes |
| Working tree status | local Git | no, last-known only | yes |
| Commit history | local Git | yes | yes |
| File diffs | local Git | no, computed on demand | yes |
| Repository groups/order | SwiftData | yes | yes |
| GitHub account tokens | Keychain | no | no |
| PRs/reviews/checks | GitHub API | yes | no |
| Analytics | derived from local Git | yes | yes |
| Spotlight index | derived from local Git/cache | external index | yes |

## Refresh Triggers

| Trigger | Refresh |
|---|---|
| App launch | repository metadata, selected repo status, stale GitHub cache opportunistically |
| Repository selected | branch, status, recent commits, active feature data |
| FSEvents `.git` change | branch, refs, commit cache, status |
| FSEvents worktree change | status, staging view, analytics invalidation marker |
| Manual refresh | local Git status, commit cache, GitHub metadata if online |
| Fetch/pull/push completes | branch sync status, commit cache, PR/check state |
| Commit/stash/merge/rebase completes | status, history, analytics cache invalidation |
| Account sign-in | GitHub metadata sync for mapped repos |

## Staleness Policy

| Cache | Freshness Rule |
|---|---|
| Commit cache | Valid until repository HEAD or refs change |
| Analytics cache | Valid until commit cache changes or analytics version changes |
| GitHub PR cache | Fresh for 5 minutes while online; valid as last-known offline |
| Avatar cache | Fresh for 7 days; can remain stale indefinitely if offline |
| Sidebar metadata | Refresh on app launch and repository events |
| Spotlight index | Eventually consistent; never blocks app workflows |

## Offline Behavior

- Local Git operations continue normally.
- GitHub tabs show last-known data with an offline banner.
- Pull, push, fetch, PR creation, and review submission are disabled or queued only where safe.
- Analytics continue from local Git data.
- Repository discovery and manual add continue if file access is available.

## Conflict Rules

- If SwiftData cache disagrees with local Git, local Git wins.
- If GitHub cache disagrees with local Git branch state, show both states and require explicit user action.
- If external tools mutate the repository during an operation, cancel or refresh unless libgit2 reports a safe continuation state.
- Derived caches must be deleted/recomputed rather than hand-edited.
