import SwiftUI

struct StagingView: View {
    let repository: Repository

    var body: some View {
        HSplitView {
            List {
                Section("Staged Changes") {
                    ForEach(repository.changedFiles.filter { $0.status == .added }) { file in
                        ChangedFileRow(file: file)
                    }
                }

                Section("Unstaged Changes") {
                    ForEach(repository.changedFiles.filter { $0.status != .added && $0.status != .untracked }) { file in
                        ChangedFileRow(file: file)
                    }
                }

                Section("Untracked Files") {
                    ForEach(repository.changedFiles.filter { $0.status == .untracked }) { file in
                        ChangedFileRow(file: file)
                    }
                }
            }
            .frame(minWidth: 300)

            DiffPlaceholderView(file: repository.changedFiles.first)
                .frame(minWidth: 420)
        }
    }
}

private struct DiffPlaceholderView: View {
    let file: ChangedFile?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Label(file?.path ?? "Select a file", systemImage: "doc.text")
                    .font(.headline)
                Spacer()
                Button("Stage Hunk", systemImage: "plus.rectangle.on.folder") {}
            }
            .padding()

            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    DiffLine(prefix: "@@", text: " func renderWorkspace() -> some View {", tint: .secondary)
                    DiffLine(prefix: "-", text: "     Text(\"Hello, world!\")", tint: .red.opacity(0.18))
                    DiffLine(prefix: "+", text: "     RepositoryWorkspace()", tint: .green.opacity(0.18))
                    DiffLine(prefix: "+", text: "     AnalyticsDashboardView(repository: repository)", tint: .green.opacity(0.18))
                    DiffLine(prefix: " ", text: " }", tint: .clear)
                }
                .font(.system(.body, design: .monospaced))
                .padding()
            }
        }
    }
}

private struct DiffLine: View {
    let prefix: String
    let text: String
    let tint: Color

    var body: some View {
        HStack(spacing: 10) {
            Text(prefix)
                .frame(width: 20, alignment: .center)
                .foregroundStyle(.secondary)
            Text(text)
            Spacer()
        }
        .padding(.vertical, 2)
        .background(tint)
    }
}
