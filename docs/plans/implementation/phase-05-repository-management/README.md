# Phase 05: Repository Management

## Objective

Ship the repository sidebar and management workflows: discover, add, clone, organize, search, reorder, and remove from GlassHub.

## Scope

- Automatic discovery of common folders.
- Manual add via drag-and-drop and open panel.
- Clone from GitHub and arbitrary Git URLs.
- Repository groups, ordering, recents, and context menu actions.
- Sidebar live status indicators.

## Implementation Tasks

- Replace current scanner with sandbox-aware security-scoped bookmark handling.
- Implement drag-and-drop folder add using `Transferable` and `NSOpenPanel`.
- Add clone destination picker and clone progress UI.
- Add repository groups with collapse/reorder persistence.
- Add Finder, Terminal, Xcode, path copy, and reveal `.git` actions.
- Add sidebar fuzzy search backed by the shared search index.

## Acceptance Criteria

- Users can add existing local repositories without leaving the app.
- Sidebar ordering and grouping survive relaunch.
- Clone workflows show progress, failure, and cancellation.
- Removing from GlassHub never deletes files from disk.

## Existing Skills To Apply

- `swiftui-design`
- `swiftui-pro-patterns`
- `feature-planning`

## Risks

- App sandbox can prevent scanning folders unless the user grants access.
- Automatic discovery must avoid traversing huge directories forever.
- External changes from Terminal/Xcode must update without noisy refreshes.
