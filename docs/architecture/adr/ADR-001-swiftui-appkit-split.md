# ADR-001: SwiftUI-First UI With Targeted AppKit Bridges

## Status

Accepted

## Context

GlassHub targets macOS 14+ and should feel like a modern native Mac app. SwiftUI gives the app a productive, declarative foundation for `NavigationSplitView`, menus, charts, settings, and shared components. Some required workflows still need AppKit, especially advanced text rendering, file panels, pasteboard behavior, responder-chain integration, and possibly custom diff views.

## Decision

Use SwiftUI for primary UI composition and feature screens. Use AppKit bridges only when SwiftUI cannot meet correctness, performance, or platform behavior requirements.

Expected bridge areas:

- Diff text rendering and syntax highlighting.
- Large text selection and line-number gutters.
- Advanced file panels or pasteboard interactions.
- Window/responder-chain behavior not exposed cleanly in SwiftUI.

## Alternatives Considered

- AppKit-only app: more mature macOS controls, but slower UI iteration and less alignment with the product's SwiftUI-native goal.
- SwiftUI-only app: simpler consistency, but risky for large diff rendering and deep macOS behaviors.
- Cross-platform UI framework: rejected because native macOS integration is a core product differentiator.

## Consequences

- SwiftUI remains the default.
- Every AppKit bridge needs a small wrapper, clear ownership, and tests where possible.
- AppKit delegates/coordinators must not own business logic.
- Feature teams must justify new bridges against performance or platform requirements.

## Rollback Path

If a SwiftUI implementation fails performance or correctness criteria, isolate the affected view and replace it with an AppKit bridge behind the same SwiftUI-facing API. If an AppKit bridge becomes unnecessary in a later macOS release, replace it without changing feature view models.
