import SwiftUI

struct ContentView: View {
    @Environment(AppState.self) private var appState
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
        @Bindable var appState = appState

        NavigationSplitView(columnVisibility: $columnVisibility) {
            RepositorySidebar()
                .navigationSplitViewColumnWidth(min: 260, ideal: 320, max: 420)
        } content: {
            RepositoryWorkspace()
                .navigationSplitViewColumnWidth(min: 620, ideal: 920)
        } detail: {
            InspectorPanel()
                .navigationSplitViewColumnWidth(min: 280, ideal: 340, max: 460)
        }
        .sheet(isPresented: $appState.isCommandPalettePresented) {
            CommandPaletteView()
                .frame(minWidth: 720, minHeight: 440)
        }
        .task {
            await appState.bootstrap()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(AppState.preview)
    }
}
