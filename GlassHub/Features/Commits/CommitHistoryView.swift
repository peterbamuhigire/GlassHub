import SwiftUI

struct CommitHistoryView: View {
    @Environment(AppState.self) private var appState
    let repository: Repository

    var body: some View {
        @Bindable var appState = appState

        VStack(spacing: 0) {
            HStack {
                Label("Commit History", systemImage: "point.3.connected.trianglepath.dotted")
                    .font(.headline)
                Spacer()
                Text("\(repository.commits.count) commits")
                    .foregroundStyle(.secondary)
            }
            .padding()

            List(selection: $appState.selectedCommitID) {
                ForEach(Array(repository.commits.enumerated()), id: \.element.id) { index, commit in
                    HStack(alignment: .top, spacing: 12) {
                        CommitGraphLane(index: index, isHead: index == 0)
                            .frame(width: 34, height: 58)

                        CommitRow(commit: commit, isSelected: appState.selectedCommitID == commit.id)
                    }
                    .tag(commit.id)
                    .onTapGesture {
                        appState.select(commit)
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct CommitRow: View {
    let commit: Commit
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(.tertiary)
                .overlay(Text(String(commit.author.prefix(1))).font(.caption.weight(.bold)))
                .frame(width: 32, height: 32)

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 8) {
                    Text(commit.subject)
                        .font(.callout.weight(.medium))
                        .lineLimit(1)

                    ForEach(commit.branchTags, id: \.self) { tag in
                        Label(tag, systemImage: "arrow.triangle.branch")
                            .font(.caption2.weight(.medium))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(.quaternary, in: Capsule())
                    }
                }

                HStack(spacing: 8) {
                    Text(commit.shortSHA)
                        .font(.caption.monospaced())
                    Text(commit.author)
                    Text(commit.date, style: .relative)
                    Text("+\(commit.additions)")
                        .foregroundStyle(GlassHubTheme.positive)
                    Text("-\(commit.deletions)")
                        .foregroundStyle(GlassHubTheme.negative)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .background(isSelected ? Color.accentColor.opacity(0.12) : .clear, in: RoundedRectangle(cornerRadius: 6))
    }
}

private struct CommitGraphLane: View {
    let index: Int
    let isHead: Bool

    var body: some View {
        Canvas { context, size in
            let centerX = size.width / 2
            let path = Path { path in
                path.move(to: CGPoint(x: centerX, y: 0))
                path.addLine(to: CGPoint(x: centerX, y: size.height))
            }
            context.stroke(path, with: .color(.blue.opacity(0.7)), lineWidth: 2)

            let circle = Path(ellipseIn: CGRect(x: centerX - 5, y: 12, width: 10, height: 10))
            context.fill(circle, with: .color(isHead ? .green : .blue))
        }
        .accessibilityLabel(index == 0 ? "Head commit graph lane" : "Commit graph lane")
    }
}
