import SwiftUI

struct RepositorySidebar: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        @Bindable var appState = appState

        List(selection: $appState.selectedRepositoryID) {
            if appState.isDiscoveringRepositories {
                Label("Discovering local repositories", systemImage: "magnifyingglass")
                    .foregroundStyle(.secondary)
            }

            ForEach(appState.filteredGroups) { group in
                Section(group.name) {
                    ForEach(group.repositories) { repository in
                        RepositorySidebarRow(repository: repository)
                            .tag(repository.id)
                            .contextMenu {
                                Button("Open in Finder", systemImage: "finder") {}
                                Button("Open in Terminal", systemImage: "terminal") {}
                                Button("Copy Repository Path", systemImage: "doc.on.doc") {
                                    NSPasteboard.general.clearContents()
                                    NSPasteboard.general.setString(repository.path, forType: .string)
                                }
                                Divider()
                                Button("Remove from GlassHub", systemImage: "minus.circle") {}
                            }
                            .onTapGesture {
                                appState.select(repository)
                            }
                    }
                }
            }
        }
        .searchable(text: $appState.searchText, prompt: "Search repositories")
        .navigationTitle("GlassHub")
        .toolbar {
            ToolbarItemGroup {
                Button {
                    Task { await appState.bootstrap() }
                } label: {
                    Label("Discover Repositories", systemImage: "arrow.clockwise")
                }

                Button {
                    appState.isCommandPalettePresented = true
                } label: {
                    Label("Command Palette", systemImage: "command")
                }
                .keyboardShortcut("k", modifiers: [.command])
            }
        }
    }
}

private struct RepositorySidebarRow: View {
    let repository: Repository

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: repository.syncStatus.systemImage)
                .foregroundStyle(repository.syncStatus.tint)
                .frame(width: 18)

            VStack(alignment: .leading, spacing: 3) {
                Text(repository.name)
                    .font(.callout.weight(.medium))
                    .lineLimit(1)
                Text(repository.currentBranch)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer(minLength: 8)
        }
        .frame(minHeight: GlassHubTheme.sidebarRowHeight)
    }
}
