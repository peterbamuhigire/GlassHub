# Phase 15: Quality, Testing, And CI

## Objective

Build the verification system needed to trust GlassHub releases.

## Scope

- Unit tests for models, fuzzy search, analytics aggregation, Git operation mapping, auth, and API decoding.
- Integration tests with fixture repositories.
- UI tests for core workflows.
- Snapshot tests for analytics and diff views.
- Static analysis, dependency review, and CI pipeline.

## Implementation Tasks

- Add fixture repositories with scripted histories and conflict states.
- Add test doubles for GitHub API and Keychain.
- Add XCUITest flows: add repo, view commits, stage file, commit, switch branch.
- Add snapshot tests for charts, commit list, inspector, and diff states.
- Add GitHub Actions or Xcode Cloud CI plan.
- Add release evidence template for every beta/App Store candidate.

## Acceptance Criteria

- Main branch requires build and test checks.
- High-risk Git operations have automated coverage.
- UI smoke tests cover the critical first-run journey.
- CI stores artifacts and logs needed for release evidence.

## Existing Skills To Apply

- `advanced-testing-strategy`
- `ios-tdd`
- `cicd-pipeline-design`
- `cicd-devsecops`

## Risks

- Git fixtures can become slow or flaky if generated at runtime.
- UI tests need stable identifiers from the start.
- CI macOS runners and Xcode versions must match supported build settings.
