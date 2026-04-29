# Phase 07: GitHub API Integration

## Objective

Implement REST and GraphQL API clients for remote repository metadata, pull requests, reviews, checks, issues, notifications, and clone search.

## Scope

- REST client with pagination, rate-limit handling, conditional requests, and retries.
- GraphQL client for pull request details, review threads, and check runs.
- Repository metadata sync.
- API cache policy and offline behavior.

## Implementation Tasks

- Add typed endpoint definitions for REST calls.
- Add GraphQL operation models and response decoding.
- Implement rate-limit state and user-visible degraded state.
- Add ETag/If-None-Match support where applicable.
- Add network fixtures and contract-style tests.
- Add sync scheduler per repository/account.

## Acceptance Criteria

- Remote metadata loads for public, private, and organization repositories.
- API failures do not break local Git workflows.
- Rate-limit and auth-expired states have clear UI.
- Network decoding is covered by fixture tests.

## Existing Skills To Apply

- `api-design-first`
- `api-error-handling`
- `api-testing-verification`
- `ios-networking-advanced`

## Risks

- REST and GraphQL models can drift from API reality.
- Over-syncing will waste rate limit and battery.
- Enterprise Server may lag github.com API features.
