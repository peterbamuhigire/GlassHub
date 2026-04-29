# Phase 08: Commit History And Graph

## Objective

Build a fast, Git-accurate commit timeline with branch graph rendering, filtering, selection, and commit details.

## Scope

- Streaming commit history.
- Commit row UI with author, SHA, time, stats, avatars, tags, and branch tips.
- DAG lane allocation and Canvas graph rendering.
- Search and filters by author, branch, file, date, regex, and SHA.
- Inspector commit detail.

## Implementation Tasks

- Implement commit batch loading from `GitActor`.
- Build `CommitGraphRenderer` lane allocation algorithm.
- Add author avatar cache with GitHub and Gravatar fallback.
- Add filter view model with composable predicates.
- Add keyboard navigation and context menus.
- Add performance tests using generated large histories.

## Acceptance Criteria

- First 200 commits render quickly.
- 10,000+ commit repositories remain responsive.
- Merge commits and branch lanes render consistently.
- Commit detail and file list update without losing selection.

## Existing Skills To Apply

- `swiftui-pro-patterns`
- `data-visualization`
- `advanced-testing-strategy`

## Risks

- Graph layout can become expensive if recomputed for every scroll update.
- Avatar loading must not block rows.
- Regex filtering can become slow on large histories.
