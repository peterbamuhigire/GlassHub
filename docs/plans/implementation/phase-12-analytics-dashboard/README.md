# Phase 12: Analytics Dashboard

## Objective

Build the analytics layer that differentiates GlassHub: commit frequency, churn, contributors, heatmap, most-changed files, and language breakdown.

## Scope

- Swift Charts dashboards per repository.
- Analytics cache and recomputation policy.
- Contributor breakdown and commit bars.
- Additions/deletions overlay.
- Code churn and most-changed files.
- 52-week contribution heatmap.
- Language breakdown.

## Implementation Tasks

- Define analytics aggregation actor fed by commit history and file diffs.
- Build chart components with clear visual hierarchy and accessibility labels.
- Add date range and branch filters.
- Add export/share actions for charts where useful.
- Cache expensive aggregations in SwiftData.
- Add snapshot tests for analytics views.

## Acceptance Criteria

- Analytics render from local repository data offline.
- Charts avoid clutter and use appropriate visual types.
- Cache invalidates after new commits, branch changes, or repository refresh.
- Snapshot tests catch visual regressions for key dashboard states.

## Existing Skills To Apply

- `data-visualization`
- `swiftui-design`
- `advanced-testing-strategy`

## Risks

- Analytics can become slow if every dashboard recomputes from raw history.
- Misleading charts can damage trust.
- Large monorepos may require incremental aggregation.
