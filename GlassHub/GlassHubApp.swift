//
//  GlassHubApp.swift
//  GlassHub
//
//  Created by TECH-KOP-PRO on 29/04/2026.
//

import SwiftUI

@main
struct GlassHubApp: App {
    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appState)
                .frame(minWidth: 1120, minHeight: 720)
        }
        .commands {
            AppCommands(appState: appState)
        }

        MenuBarExtra {
            MenuBarStatusView()
                .environment(appState)
        } label: {
            Label(
                appState.selectedRepository?.currentBranch ?? "GlassHub",
                systemImage: appState.selectedRepository?.syncStatus.systemImage ?? "circle.hexagongrid"
            )
        }
    }
}
