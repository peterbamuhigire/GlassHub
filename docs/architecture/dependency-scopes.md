# Dependency Scopes

GlassHub dependencies are scoped by lifetime. The goal is to keep global state small, avoid optional account/session checks inside signed-in flows, and prevent repository-specific state from leaking across windows or operations.

## Scope Table

| Scope | Lifetime | Examples | Creation Owner |
|---|---|---|---|
| App | Process launch to quit | Logger, app settings, persistence container, account store, command registry | `GlassHubApp` |
| Account | Sign-in to sign-out | GitHub client, rate-limit state, account metadata, token accessor | `AuthActor` / account container |
| Repository | Repository open to close/remove | Git actor handle, repository cache, file monitor, analytics aggregator | repository coordinator |
| Feature | Feature view entry to exit | commit list view model, staging view model, PR detail view model | feature container |
| Interaction | Operation start to finish | clone task, commit task, rebase task, API request, indexing pass | command/action handler |

## App Scope

App scope is for dependencies that are valid regardless of selected account or repository.

- `AppState`
- `ModelContainer`
- account registry
- app preferences
- logger
- command registry
- shared URLSession configuration

App scope must not hold a mutable current repository handle. Selection belongs in app state, but repository operations belong to repository scope.

## Account Scope

Account scope begins after OAuth succeeds. Inside this scope, the GitHub account is non-optional.

- GitHub REST client
- GraphQL client
- rate-limit tracker
- notification sync
- token accessor backed by Keychain

Account scope can be destroyed independently when the user signs out or removes an account.

## Repository Scope

Repository scope captures an immutable repository URL/security-scoped bookmark plus mutable repository state behind actors.

- `GitActor` repository handle
- FSEvents monitor
- commit cache coordinator
- analytics aggregator
- repository/account mapping

Repository scope must work without account scope. A local repo with no GitHub account remains usable.

## Feature Scope

Feature scope owns screen-level view models and task cancellation.

- commit history loader
- staging area state
- branch operation coordinator
- PR detail loader
- analytics dashboard filters

Feature scope should be disposable. Leaving a feature cancels its long-running work unless the operation has been promoted to interaction scope.

## Interaction Scope

Interaction scope owns one explicit user operation.

- clone
- fetch/pull/push
- commit
- merge/rebase/cherry-pick
- GitHub review submit
- Spotlight indexing pass

Every interaction needs progress, cancellation policy, error mapping, and completion event.

## Construction Rule

Parent scopes can create child scopes. Child scopes cannot reach back into siblings.

```text
AppContainer
  -> AccountContainer
  -> RepositoryContainer
      -> FeatureContainer
          -> Interaction
```

Repository scope may exist without account scope. Account scope may exist without an open repository.
