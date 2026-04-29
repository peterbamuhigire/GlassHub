import SwiftUI

struct PullRequestsView: View {
    let repository: Repository

    var body: some View {
        if repository.pullRequests.isEmpty {
            ContentUnavailableView(
                "No Pull Requests",
                systemImage: "arrow.triangle.pull",
                description: Text("GitHub REST and GraphQL integration will populate this view.")
            )
        } else {
            List(repository.pullRequests) { pullRequest in
                HStack(spacing: 12) {
                    Text("#\(pullRequest.id)")
                        .font(.callout.monospaced())
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(pullRequest.title)
                            .font(.callout.weight(.medium))
                        Text("\(pullRequest.author) opened from \(pullRequest.branch)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Text(pullRequest.status)
                        .font(.caption.weight(.medium))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.quaternary, in: Capsule())
                }
                .padding(.vertical, 8)
            }
        }
    }
}
