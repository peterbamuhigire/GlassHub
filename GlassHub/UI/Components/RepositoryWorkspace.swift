import SwiftUI

struct RepositoryWorkspace: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        @Bindable var appState = appState

        Group {
            if let repository = appState.selectedRepository {
                VStack(spacing: 0) {
                    RepositoryHeader(repository: repository)

                    Picker("Workspace", selection: $appState.selectedWorkspaceTab) {
                        ForEach(WorkspaceTab.allCases) { tab in
                            Label(tab.rawValue, systemImage: tab.systemImage).tag(tab)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding([.horizontal, .bottom], GlassHubTheme.contentSpacing)

                    Divider()

                    switch appState.selectedWorkspaceTab {
                    case .overview:
                        RepositoryOverviewView(repository: repository)
                    case .commits:
                        CommitHistoryView(repository: repository)
                    case .staging:
                        StagingView(repository: repository)
                    case .branches:
                        BranchesView(repository: repository)
                    case .pullRequests:
                        PullRequestsView(repository: repository)
                    case .analytics:
                        AnalyticsDashboardView(repository: repository)
                    }
                }
            } else {
                ContentUnavailableView(
                    "No Repository Selected",
                    systemImage: "folder.badge.questionmark",
                    description: Text("Add or select a local Git repository to begin.")
                )
            }
        }
    }
}

private struct RepositoryHeader: View {
    let repository: Repository

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "shippingbox")
                .font(.system(size: 28))
                .foregroundStyle(.tint)

            VStack(alignment: .leading, spacing: 4) {
                Text(repository.name)
                    .font(.title2.weight(.semibold))
                Text(repository.path)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            Label(repository.currentBranch, systemImage: "arrow.triangle.branch")
                .font(.callout.weight(.medium))
                .labelStyle(.titleAndIcon)

            Label(repository.syncStatus.rawValue, systemImage: repository.syncStatus.systemImage)
                .font(.callout.weight(.medium))
                .foregroundStyle(repository.syncStatus.tint)
        }
        .padding(GlassHubTheme.contentSpacing)
    }
}

private struct RepositoryOverviewView: View {
    let repository: Repository

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                SectionHeader(title: "Repository Health", subtitle: "Local-first status summary")

                HStack(spacing: 12) {
                    MetricTile(title: "Commits", value: "\(repository.commits.count)", systemImage: "clock.arrow.circlepath")
                    MetricTile(title: "Changed Files", value: "\(repository.changedFiles.count)", systemImage: "doc.text.magnifyingglass")
                    MetricTile(title: "Branches", value: "\(repository.branches.count)", systemImage: "arrow.triangle.branch")
                    MetricTile(title: "Pull Requests", value: "\(repository.pullRequests.count)", systemImage: "arrow.triangle.pull")
                }

                SectionHeader(title: "Most Recent Work", subtitle: "Seed data now, GitActor-backed streams next")

                ForEach(repository.commits.prefix(5)) { commit in
                    CommitRow(commit: commit, isSelected: false)
                }
            }
            .padding(GlassHubTheme.contentSpacing)
        }
    }
}

struct MetricTile: View {
    let title: String
    let value: String
    let systemImage: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: systemImage)
                .foregroundStyle(.tint)
            Text(value)
                .font(.title2.weight(.semibold))
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.quaternary.opacity(0.55), in: RoundedRectangle(cornerRadius: GlassHubTheme.compactRadius))
    }
}

struct SectionHeader: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
