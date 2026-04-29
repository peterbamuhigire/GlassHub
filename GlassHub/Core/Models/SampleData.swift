import Foundation
import SwiftUI

enum SampleData {
    static let accounts = [
        GitHubAccount(username: "peter", host: "github.com", avatarSystemImage: "person.crop.circle.fill"),
        GitHubAccount(username: "chwezi", host: "github.enterprise", avatarSystemImage: "building.2.crop.circle.fill")
    ]

    static let repositoryGroups: [RepositoryGroup] = [
        RepositoryGroup(name: "Recently Opened", repositories: [glassHub, chwezicoreAPI]),
        RepositoryGroup(name: "Chwezi Core", repositories: [kampuspad])
    ]

    static let glassHub = Repository(
        name: "GlassHub",
        owner: "Chwezi",
        path: "~/Sites/GlassHub",
        currentBranch: "main",
        syncStatus: .ahead,
        languageBreakdown: [
            LanguageStat(name: "Swift", percentage: 82, colorName: .blue),
            LanguageStat(name: "Shell", percentage: 10, colorName: .green),
            LanguageStat(name: "Markdown", percentage: 8, colorName: .gray)
        ],
        commits: commits(prefix: "GlassHub", branch: "main"),
        changedFiles: [
            ChangedFile(path: "GlassHub/App/AppState.swift", status: .added, additions: 144, deletions: 0),
            ChangedFile(path: "GlassHub/Features/Analytics/AnalyticsDashboardView.swift", status: .added, additions: 210, deletions: 0),
            ChangedFile(path: "README.md", status: .modified, additions: 48, deletions: 3)
        ],
        branches: [
            Branch(name: "main", isCurrent: true, ahead: 2, behind: 0, lastCommitSubject: "Kickstart native app shell"),
            Branch(name: "feature/github-device-flow", isCurrent: false, ahead: 6, behind: 1, lastCommitSubject: "Add OAuth polling service"),
            Branch(name: "feature/repo-discovery", isCurrent: false, ahead: 3, behind: 0, lastCommitSubject: "Scan common development folders")
        ],
        pullRequests: [
            PullRequest(id: 12, title: "Add repository discovery pipeline", author: "peter", status: "Ready", branch: "feature/repo-discovery"),
            PullRequest(id: 9, title: "Prototype analytics dashboard", author: "chwezi", status: "Draft", branch: "feature/analytics")
        ],
        weeklyActivity: weeklyActivity()
    )

    static let chwezicoreAPI = Repository(
        name: "Chwezi Core API",
        owner: "Chwezi Core Systems",
        path: "~/Developer/chwezicore-api",
        currentBranch: "release/v1",
        syncStatus: .synced,
        languageBreakdown: [
            LanguageStat(name: "Swift", percentage: 46, colorName: .blue),
            LanguageStat(name: "PostgreSQL", percentage: 22, colorName: .purple),
            LanguageStat(name: "TypeScript", percentage: 32, colorName: .orange)
        ],
        commits: commits(prefix: "API", branch: "release/v1"),
        changedFiles: [
            ChangedFile(path: "Sources/API/Routes.swift", status: .modified, additions: 38, deletions: 12),
            ChangedFile(path: "Package.swift", status: .modified, additions: 4, deletions: 2)
        ],
        branches: [
            Branch(name: "release/v1", isCurrent: true, ahead: 0, behind: 0, lastCommitSubject: "Prepare release build"),
            Branch(name: "main", isCurrent: false, ahead: 0, behind: 12, lastCommitSubject: "Merge analytics endpoint")
        ],
        pullRequests: [],
        weeklyActivity: weeklyActivity()
    )

    static let kampuspad = Repository(
        name: "kampuspad",
        owner: "Chwezi",
        path: "~/Projects/kampuspad",
        currentBranch: "feature/offline-sync",
        syncStatus: .behind,
        languageBreakdown: [
            LanguageStat(name: "Swift", percentage: 70, colorName: .blue),
            LanguageStat(name: "Kotlin", percentage: 18, colorName: .pink),
            LanguageStat(name: "Markdown", percentage: 12, colorName: .gray)
        ],
        commits: commits(prefix: "Kampus", branch: "feature/offline-sync"),
        changedFiles: [
            ChangedFile(path: "Sources/Sync/OfflineQueue.swift", status: .modified, additions: 71, deletions: 22),
            ChangedFile(path: "Sources/Sync/ConflictResolver.swift", status: .added, additions: 118, deletions: 0),
            ChangedFile(path: "Tests/SyncTests.swift", status: .modified, additions: 54, deletions: 18)
        ],
        branches: [
            Branch(name: "feature/offline-sync", isCurrent: true, ahead: 4, behind: 2, lastCommitSubject: "Handle conflict retries"),
            Branch(name: "main", isCurrent: false, ahead: 0, behind: 8, lastCommitSubject: "Update onboarding")
        ],
        pullRequests: [
            PullRequest(id: 33, title: "Offline sync conflict handling", author: "peter", status: "Changes requested", branch: "feature/offline-sync")
        ],
        weeklyActivity: weeklyActivity()
    )

    static func commits(prefix: String, branch: String) -> [Commit] {
        let subjects = [
            "Kickstart native app shell",
            "Add repository discovery flow",
            "Render commit graph prototype",
            "Introduce analytics dashboard",
            "Wire branch status badges",
            "Add command palette surface",
            "Prepare SwiftData model boundary",
            "Sketch GitHub API client"
        ]

        return subjects.enumerated().map { index, subject in
            Commit(
                sha: "\(prefix.lowercased())\(index)8d2a9f4c1b673af09c3e6712cbe49a812345",
                subject: subject,
                message: "\(subject)\n\nStarter implementation for \(prefix) on \(branch).",
                author: index.isMultiple(of: 2) ? "Peter Bamuhigire" : "Chwezi Bot",
                date: Calendar.current.date(byAdding: .hour, value: -(index * 9 + 2), to: .now) ?? .now,
                additions: 24 + index * 11,
                deletions: 3 + index * 5,
                branchTags: index == 0 ? [branch] : [],
                files: [
                    ChangedFile(path: "Sources/\(prefix)/Feature\(index).swift", status: .modified, additions: 18 + index, deletions: 2 + index),
                    ChangedFile(path: "Tests/\(prefix)Tests/Feature\(index)Tests.swift", status: .added, additions: 10 + index, deletions: 0)
                ]
            )
        }
    }

    static func weeklyActivity() -> [WeeklyActivity] {
        (0..<12).map { offset in
            WeeklyActivity(
                weekStart: Calendar.current.date(byAdding: .weekOfYear, value: -offset, to: .now) ?? .now,
                commits: [7, 11, 5, 14, 9, 18, 4, 21, 13, 8, 6, 16][offset],
                additions: [220, 410, 130, 520, 260, 640, 98, 720, 360, 190, 150, 440][offset],
                deletions: [40, 130, 18, 210, 80, 170, 20, 260, 90, 60, 45, 140][offset]
            )
        }
        .reversed()
    }
}
