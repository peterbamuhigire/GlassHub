# Module Boundaries

GlassHub uses a SwiftUI application shell with feature modules around a shared core. The boundary rule is simple: `Features` compose user workflows, `Core` owns durable capabilities, `UI` owns reusable presentation components, and `App` wires process-level state.

## Top-Level Ownership

| Directory | Owns | Must Not Own |
|---|---|---|
| `App/` | App entry point, global state, commands, scene setup, dependency graph bootstrap | Git implementation details, GitHub endpoint code, feature-specific view logic |
| `Core/Models/` | Sendable domain values and shared enums | SwiftUI layout, network calls, persistence side effects |
| `Core/Git/` | Local Git operations, repository handles, Git error mapping, fixture utilities | GitHub API state, account UI, charts |
| `Core/GitHub/` | REST/GraphQL clients, pagination, rate limits, remote models | Local repository mutation, Keychain storage |
| `Core/Auth/` | OAuth device flow, account lifecycle, Keychain token references | API feature screens, local Git status |
| `Core/Persistence/` | SwiftData models, migrations, cache writes, settings storage | Token storage, view rendering |
| `Core/Search/` | Fuzzy index, command index, Spotlight indexing adapters | Command execution side effects |
| `Core/Analytics/` | Commit/file aggregation, churn calculations, heatmap data | Chart layout and presentation |
| `Core/MacOS/` | Spotlight, Quick Look, notifications, menu bar, share, handoff services | Feature-specific business logic |
| `Features/` | User workflows and feature view models | Low-level Git/libgit2 calls, raw URLSession calls, raw Keychain access |
| `UI/` | Reusable controls, chart components, theme constants | Business state ownership or network side effects |

## Feature Ownership

| Feature | Directory | Primary Dependencies |
|---|---|---|
| Repository discovery, add, clone, grouping | `Features/Repositories` | `Core/Git`, `Core/Persistence`, `Core/Search`, `Core/MacOS` |
| Commit timeline and graph | `Features/Commits` | `Core/Git`, `Core/Search`, `UI/Components` |
| Working tree, staging, committing | `Features/Staging` | `Core/Git`, `UI/Components`, AppKit diff bridge |
| Branching, merge, rebase, stash | `Features/Branches` | `Core/Git`, `Core/Persistence` |
| Pull requests and reviews | `Features/PullRequests` | `Core/GitHub`, `Core/Git`, `Core/Auth` |
| Analytics dashboard | `Features/Analytics` | `Core/Analytics`, `Core/Git`, `Core/Persistence`, `UI/Charts` |
| Settings and accounts | `Features/Settings` | `Core/Auth`, `Core/Persistence` |
| Command palette | `Features/CommandPalette` | `Core/Search`, command registry, focused app state |
| Menu bar status | `Features/MenuBarExtra` | `Core/Git`, `Core/MacOS`, app selection state |

## Dependency Direction

Allowed direction:

```text
App -> Features -> Core
App -> UI
Features -> UI
UI -> Core/Models only
Core modules -> Core/Models
```

Disallowed direction:

```text
Core -> Features
Core -> UI
UI -> Features
Core/Git -> Core/GitHub
Core/GitHub -> Core/Git
```

## Boundary Rules

- Feature view models receive protocols, not concrete service singletons.
- `Core/Git` and `Core/GitHub` do not know about SwiftUI views.
- `Core/Auth` returns account/session values and Keychain references, not raw token strings to UI code.
- `Core/Persistence` can store cache metadata, but cannot become the source of truth for live repository status.
- Reusable UI components accept value models and callbacks; they do not fetch data themselves.
