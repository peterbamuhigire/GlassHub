import Foundation
import SwiftData

extension SchemaV1 {
    @Model
    final class StoredCommitCache {
        @Attribute(.unique) var id: UUID
        var sha: String
        var subject: String
        var message: String
        var author: String
        var date: Date
        var additions: Int
        var deletions: Int
        var branchTagsJSON: Data
        var fetchedAt: Date

        var repository: StoredRepository?

        init(
            id: UUID = UUID(),
            sha: String,
            subject: String,
            message: String,
            author: String,
            date: Date,
            additions: Int,
            deletions: Int,
            branchTagsJSON: Data = Data("[]".utf8),
            fetchedAt: Date = .now,
            repository: StoredRepository? = nil
        ) {
            self.id = id
            self.sha = sha
            self.subject = subject
            self.message = message
            self.author = author
            self.date = date
            self.additions = additions
            self.deletions = deletions
            self.branchTagsJSON = branchTagsJSON
            self.fetchedAt = fetchedAt
            self.repository = repository
        }
    }
}
