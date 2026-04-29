import SwiftUI

struct BranchesView: View {
    let repository: Repository

    var body: some View {
        List(repository.branches) { branch in
            HStack(spacing: 12) {
                Image(systemName: branch.isCurrent ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(branch.isCurrent ? .green : .secondary)

                VStack(alignment: .leading, spacing: 4) {
                    Text(branch.name)
                        .font(.callout.weight(.medium))
                    Text(branch.lastCommitSubject)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if branch.ahead > 0 {
                    Label("\(branch.ahead)", systemImage: "arrow.up")
                }
                if branch.behind > 0 {
                    Label("\(branch.behind)", systemImage: "arrow.down")
                }
            }
            .padding(.vertical, 8)
        }
    }
}
