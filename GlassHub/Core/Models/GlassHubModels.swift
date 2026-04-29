import Foundation
import SwiftUI

enum WorkspaceTab: String, CaseIterable, Identifiable, Sendable {
    case overview = "Overview"
    case commits = "Commits"
    case staging = "Staging"
    case branches = "Branches"
    case pullRequests = "Pull Requests"
    case analytics = "Analytics"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .overview: "rectangle.grid.2x2"
        case .commits: "point.3.connected.trianglepath.dotted"
        case .staging: "checklist"
        case .branches: "arrow.triangle.branch"
        case .pullRequests: "arrow.triangle.pull"
        case .analytics: "chart.xyaxis.line"
        }
    }
}

struct RepositoryGroup: Identifiable, Hashable, Sendable {
    var id = UUID()
    var name: String
    var repositories: [Repository]
}

struct Repository: Identifiable, Hashable, Sendable {
    var id = UUID()
    var name: String
    var owner: String
    var path: String
    var currentBranch: String
    var syncStatus: SyncStatus
    var languageBreakdown: [LanguageStat]
    var commits: [Commit]
    var changedFiles: [ChangedFile]
    var branches: [Branch]
    var pullRequests: [PullRequest]
    var weeklyActivity: [WeeklyActivity]
}

enum SyncStatus: String, Hashable, Sendable {
    case synced = "Synced"
    case ahead = "Ahead"
    case behind = "Behind"
    case diverged = "Diverged"
    case conflicts = "Conflicts"
    case offline = "Offline"

    var systemImage: String {
        switch self {
        case .synced: "checkmark.circle.fill"
        case .ahead: "arrow.up.circle.fill"
        case .behind: "arrow.down.circle.fill"
        case .diverged: "arrow.up.arrow.down.circle.fill"
        case .conflicts: "exclamationmark.triangle.fill"
        case .offline: "wifi.slash"
        }
    }

    var tint: Color {
        switch self {
        case .synced: .green
        case .ahead: .blue
        case .behind: .orange
        case .diverged, .conflicts: .red
        case .offline: .secondary
        }
    }
}

struct Commit: Identifiable, Hashable, Sendable {
    var id: String { sha }
    var sha: String
    var subject: String
    var message: String
    var author: String
    var date: Date
    var additions: Int
    var deletions: Int
    var branchTags: [String]
    var files: [ChangedFile]

    var shortSHA: String {
        String(sha.prefix(7))
    }
}

struct ChangedFile: Identifiable, Hashable, Sendable {
    var id = UUID()
    var path: String
    var status: FileChangeStatus
    var additions: Int
    var deletions: Int
}

enum FileChangeStatus: String, Hashable, Sendable {
    case modified = "M"
    case added = "A"
    case deleted = "D"
    case renamed = "R"
    case untracked = "?"
    case conflicted = "U"

    var label: String {
        switch self {
        case .modified: "Modified"
        case .added: "Added"
        case .deleted: "Deleted"
        case .renamed: "Renamed"
        case .untracked: "Untracked"
        case .conflicted: "Unmerged"
        }
    }
}

struct Branch: Identifiable, Hashable, Sendable {
    var id = UUID()
    var name: String
    var isCurrent: Bool
    var ahead: Int
    var behind: Int
    var lastCommitSubject: String
}

struct PullRequest: Identifiable, Hashable, Sendable {
    var id: Int
    var title: String
    var author: String
    var status: String
    var branch: String
}

struct LanguageStat: Identifiable, Hashable, Sendable {
    var id = UUID()
    var name: String
    var percentage: Double
    var colorName: LanguageColor

    var color: Color {
        colorName.color
    }
}

enum LanguageColor: String, Hashable, Sendable {
    case blue
    case gray
    case green
    case orange
    case pink
    case purple

    var color: Color {
        switch self {
        case .blue: .blue
        case .gray: .gray
        case .green: .green
        case .orange: .orange
        case .pink: .pink
        case .purple: .purple
        }
    }
}

struct WeeklyActivity: Identifiable, Hashable, Sendable {
    var id = UUID()
    var weekStart: Date
    var commits: Int
    var additions: Int
    var deletions: Int
}

struct GitHubAccount: Identifiable, Hashable, Sendable {
    var id = UUID()
    var username: String
    var host: String
    var avatarSystemImage: String
}
