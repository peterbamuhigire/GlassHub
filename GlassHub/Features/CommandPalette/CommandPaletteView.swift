import SwiftUI

struct CommandPaletteView: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @State private var query = ""

    private var commands: [PaletteCommand] {
        [
            PaletteCommand(title: "Discover local repositories", subtitle: "Scan common folders for .git directories", systemImage: "magnifyingglass") {
                Task { await appState.bootstrap() }
            },
            PaletteCommand(title: "Open commits", subtitle: "Show selected repository history", systemImage: WorkspaceTab.commits.systemImage) {
                appState.selectedWorkspaceTab = .commits
            },
            PaletteCommand(title: "Open staging", subtitle: "Review working tree and index", systemImage: WorkspaceTab.staging.systemImage) {
                appState.selectedWorkspaceTab = .staging
            },
            PaletteCommand(title: "Open analytics", subtitle: "Show repository metrics dashboard", systemImage: WorkspaceTab.analytics.systemImage) {
                appState.selectedWorkspaceTab = .analytics
            }
        ] + appState.allRepositories.map { repository in
            PaletteCommand(title: repository.name, subtitle: repository.path, systemImage: "shippingbox") {
                appState.select(repository)
            }
        }
    }

    private var filteredCommands: [PaletteCommand] {
        guard !query.isEmpty else { return commands }
        return commands.filter {
            FuzzyIndex.matches(needle: query, haystack: $0.title)
                || FuzzyIndex.matches(needle: query, haystack: $0.subtitle)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Image(systemName: "command")
                    .foregroundStyle(.secondary)
                TextField("Search repos, commits, branches, PRs, and actions", text: $query)
                    .textFieldStyle(.plain)
                    .font(.title3)
            }
            .padding()

            Divider()

            List(filteredCommands) { command in
                Button {
                    command.action()
                    dismiss()
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: command.systemImage)
                            .frame(width: 24)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(command.title)
                            Text(command.subtitle)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .padding(.vertical, 6)
            }
            .listStyle(.plain)
        }
    }
}

private struct PaletteCommand: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var systemImage: String
    var action: () -> Void
}
