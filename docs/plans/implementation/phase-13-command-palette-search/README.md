# Phase 13: Command Palette And Search

## Objective

Make every major action reachable through a fast command palette and shared fuzzy search engine.

## Scope

- Global Command-K palette.
- Search repositories, commands, commits, branches, PRs, files, and settings.
- Context-aware actions based on selected repository, branch, commit, or file.
- Keyboard-first execution flow.

## Implementation Tasks

- Build indexed search models with scope, title, subtitle, keywords, and action.
- Implement trie or ranked fuzzy matcher with abbreviation support.
- Add command registry with permission, context, and confirmation metadata.
- Add keyboard shortcuts for high-frequency commands.
- Add action audit logging for risky commands.
- Add tests for ranking and context filtering.

## Acceptance Criteria

- Command palette opens instantly.
- `kpad`-style fuzzy matches work for repository names.
- Context-specific commands only appear when valid.
- Risky Git operations require confirmation from palette flow.

## Existing Skills To Apply

- `swiftui-pro-patterns`
- `ai-agentic-ui` for command-surface ideas, without adding AI dependency
- `advanced-testing-strategy`

## Risks

- A command registry can become stale if features bypass it.
- Search ranking must be predictable, not surprising.
- Keyboard-first flows need strong accessibility behavior.
