import Foundation
import SwiftData

extension SchemaV1 {
    @Model
    final class StoredRepositoryGroup {
        @Attribute(.unique) var id: UUID
        var name: String
        var sortIndex: Int
        var isCollapsed: Bool
        var createdAt: Date

        @Relationship(deleteRule: .nullify, inverse: \StoredRepository.group)
        var repositories: [StoredRepository] = []

        init(
            id: UUID = UUID(),
            name: String,
            sortIndex: Int = 0,
            isCollapsed: Bool = false,
            createdAt: Date = .now
        ) {
            self.id = id
            self.name = name
            self.sortIndex = sortIndex
            self.isCollapsed = isCollapsed
            self.createdAt = createdAt
        }
    }
}
