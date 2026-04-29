# Phase 11: Pull Requests And Code Review

## Objective

Implement GitHub pull request workflows: list, detail, review, comment, create, checkout, and merge readiness.

## Scope

- PR list grouped by open, draft, review requested, assigned, and merged.
- PR detail with markdown description, checks, review threads, files, and commits.
- Checkout PR branch locally.
- Create PR from current branch.
- Review comments and review submission.

## Implementation Tasks

- Build PR list and filters backed by REST/GraphQL sync.
- Render MarkdownUI for descriptions and comments.
- Build checks/status summary with failure drill-down.
- Add file review diff UI using the shared diff viewer.
- Implement create-PR form with base/head validation.
- Add review draft state and submit/cancel flows.

## Acceptance Criteria

- Users can inspect PR state without opening a browser.
- Review threads map to files and line ranges.
- PR checkout creates or updates the correct local branch.
- Create PR handles fork/org/private repository cases.

## Existing Skills To Apply

- `api-design-first`
- `ios-networking-advanced`
- `swiftui-design`

## Risks

- GitHub review-thread GraphQL models are complex.
- Markdown and code review must remain readable in narrow windows.
- Local branch state may not match remote PR branch state.
