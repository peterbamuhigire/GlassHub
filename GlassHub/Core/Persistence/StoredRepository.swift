import Foundation
import SwiftData

extension SchemaV1 {
    @Model
    final class StoredRepository {
        @Attribute(.unique) var id: UUID
        var name: String
        var owner: String
        var path: String
        var currentBranch: String
        var syncStatusRaw: String
        var lastOpenedAt: Date?
        var sortIndex: Int
        var createdAt: Date
        var updatedAt: Date

        @Relationship(deleteRule: .nullify) var group: StoredRepositoryGroup?
        @Relationship(deleteRule: .nullify) var selectedAccount: StoredAccountReference?
        @Relationship(deleteRule: .cascade, inverse: \StoredCommitCache.repository)
        var commitCaches: [StoredCommitCache] = []
        @Relationship(deleteRule: .cascade, inverse: \StoredAnalyticsSnapshot.repository)
        var analyticsSnapshots: [StoredAnalyticsSnapshot] = []

        init(
            id: UUID = UUID(),
            name: String,
            owner: String,
            path: String,
            currentBranch: String,
            syncStatusRaw: String,
            lastOpenedAt: Date? = nil,
            sortIndex: Int = 0,
            createdAt: Date = .now,
            updatedAt: Date = .now,
            group: StoredRepositoryGroup? = nil,
            selectedAccount: StoredAccountReference? = nil
        ) {
            self.id = id
            self.name = name
            self.owner = owner
            self.path = path
            self.currentBranch = currentBranch
            self.syncStatusRaw = syncStatusRaw
            self.lastOpenedAt = lastOpenedAt
            self.sortIndex = sortIndex
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.group = group
            self.selectedAccount = selectedAccount
        }
    }
}
