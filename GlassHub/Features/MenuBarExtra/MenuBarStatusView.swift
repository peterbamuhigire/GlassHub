import SwiftUI

struct MenuBarStatusView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let repository = appState.selectedRepository {
                Label(repository.name, systemImage: "shippingbox")
                    .font(.headline)
                Label(repository.currentBranch, systemImage: "arrow.triangle.branch")
                Label(repository.syncStatus.rawValue, systemImage: repository.syncStatus.systemImage)
                    .foregroundStyle(repository.syncStatus.tint)

                Divider()

                Button("Open Analytics", systemImage: WorkspaceTab.analytics.systemImage) {
                    appState.selectedWorkspaceTab = .analytics
                }
                Button("Command Palette", systemImage: "command") {
                    appState.isCommandPalettePresented = true
                }
            } else {
                Text("No repository selected")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(width: 260, alignment: .leading)
    }
}
