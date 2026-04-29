import SwiftUI

struct AppCommands: Commands {
    let appState: AppState

    var body: some Commands {
        CommandMenu("GlassHub") {
            Button("Command Palette") {
                appState.isCommandPalettePresented = true
            }
            .keyboardShortcut("k", modifiers: [.command])
        }
    }
}
