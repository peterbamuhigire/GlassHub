import SwiftUI

struct InspectorPanel: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        if let commit = appState.selectedCommit {
            CommitInspector(commit: commit)
        } else if let repository = appState.selectedRepository {
            RepositoryInspector(repository: repository)
        } else {
            ContentUnavailableView("Inspector", systemImage: "sidebar.right")
        }
    }
}

private struct CommitInspector: View {
    let commit: Commit

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                SectionHeader(title: "Commit", subtitle: commit.shortSHA)

                Text(commit.subject)
                    .font(.title3.weight(.semibold))

                Text(commit.message)
                    .font(.callout)
                    .textSelection(.enabled)

                LabeledContent("Author", value: commit.author)
                LabeledContent("Date", value: commit.date.formatted(date: .abbreviated, time: .shortened))
                LabeledContent("Additions", value: "+\(commit.additions)")
                LabeledContent("Deletions", value: "-\(commit.deletions)")

                Divider()

                SectionHeader(title: "Changed Files", subtitle: "\(commit.files.count) files touched")
                ForEach(commit.files) { file in
                    ChangedFileRow(file: file)
                }
            }
            .padding()
        }
    }
}

private struct RepositoryInspector: View {
    let repository: Repository

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Repository", subtitle: repository.owner)
            LabeledContent("Branch", value: repository.currentBranch)
            LabeledContent("Status", value: repository.syncStatus.rawValue)
            LabeledContent("Path", value: repository.path)
            Spacer()
        }
        .padding()
    }
}

struct ChangedFileRow: View {
    let file: ChangedFile

    var body: some View {
        HStack(spacing: 10) {
            Text(file.status.rawValue)
                .font(.caption.weight(.bold))
                .frame(width: 24, height: 24)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 5))

            VStack(alignment: .leading, spacing: 3) {
                Text(file.path)
                    .lineLimit(1)
                Text(file.status.label)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text("+\(file.additions)")
                .foregroundStyle(GlassHubTheme.positive)
            Text("-\(file.deletions)")
                .foregroundStyle(GlassHubTheme.negative)
        }
        .font(.callout)
    }
}
