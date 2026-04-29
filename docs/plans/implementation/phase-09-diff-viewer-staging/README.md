# Phase 09: Diff Viewer And Staging

## Objective

Build the working tree, index, diff viewer, and commit creation workflows with file, hunk, and line staging.

## Scope

- Staged, unstaged, untracked, renamed, deleted, and conflicted file sections.
- Unified and split diff modes.
- Syntax-highlighted text diffs.
- Image and binary diff handling.
- File, hunk, and line staging.
- Commit message editor and commit action.

## Implementation Tasks

- Implement status-to-section mapping from `GitActor`.
- Build AppKit-backed diff text view for large files.
- Add hunk parser and staging APIs.
- Add Option-hover line staging behavior.
- Add image diff modes: side-by-side, overlay, onion-skin, flick.
- Add commit validation and amend option.

## Acceptance Criteria

- Users can stage/unstage files and hunks.
- Line staging works for eligible text diffs.
- Large diffs remain scrollable and responsive.
- Binary files do not render as corrupt text.
- Commit creation updates history and status immediately.

## Existing Skills To Apply

- `swiftui-pro-patterns`
- `ios-production-patterns`
- `advanced-testing-strategy`

## Risks

- Hunk/line staging is correctness-critical and can corrupt intent if patch application is wrong.
- AppKit text rendering must preserve SwiftUI selection and focus behavior.
- Large files need limits and clear fallback UI.
