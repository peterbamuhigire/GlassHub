import Foundation
import SwiftData

extension SchemaV1 {
    @Model
    final class StoredAnalyticsSnapshot {
        @Attribute(.unique) var id: UUID
        var weekStart: Date
        var commits: Int
        var additions: Int
        var deletions: Int
        var languageBreakdownJSON: Data
        var capturedAt: Date

        var repository: StoredRepository?

        init(
            id: UUID = UUID(),
            weekStart: Date,
            commits: Int,
            additions: Int,
            deletions: Int,
            languageBreakdownJSON: Data = Data("[]".utf8),
            capturedAt: Date = .now,
            repository: StoredRepository? = nil
        ) {
            self.id = id
            self.weekStart = weekStart
            self.commits = commits
            self.additions = additions
            self.deletions = deletions
            self.languageBreakdownJSON = languageBreakdownJSON
            self.capturedAt = capturedAt
            self.repository = repository
        }
    }
}
