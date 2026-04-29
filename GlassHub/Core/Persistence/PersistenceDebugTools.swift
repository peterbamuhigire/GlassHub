import Foundation
import SwiftData

/// JSON dump/restore for inspecting the SwiftData store during development.
///
/// Restricted to `DEBUG` builds. Exports omit the `keychainAccount` field so debug
/// dumps can be safely shared without leaking lookup keys; restores accept dumps
/// that omit it and synthesize an empty placeholder.
enum PersistenceDebugTools {
    struct Snapshot: Codable {
        var schemaVersion: String
        var capturedAt: Date
        var repositories: [RepositoryDump]
        var groups: [GroupDump]
        var accounts: [AccountDump]
        var preferences: [PreferenceDump]

        struct RepositoryDump: Codable {
            var id: UUID
            var name: String
            var owner: String
            var path: String
            var currentBranch: String
            var syncStatusRaw: String
            var sortIndex: Int
            var groupID: UUID?
            var selectedAccountID: UUID?
        }

        struct GroupDump: Codable {
            var id: UUID
            var name: String
            var sortIndex: Int
            var isCollapsed: Bool
        }

        struct AccountDump: Codable {
            var id: UUID
            var username: String
            var host: String
            var avatarSystemImage: String
        }

        struct PreferenceDump: Codable {
            var key: String
            var valueJSON: Data
        }
    }

    static func export(from context: ModelContext) throws -> Data {
        let repositories = try context.fetch(FetchDescriptor<StoredRepository>())
        let groups = try context.fetch(FetchDescriptor<StoredRepositoryGroup>())
        let accounts = try context.fetch(FetchDescriptor<StoredAccountReference>())
        let preferences = try context.fetch(FetchDescriptor<StoredPreference>())

        let snapshot = Snapshot(
            schemaVersion: "\(SchemaV1.versionIdentifier)",
            capturedAt: .now,
            repositories: repositories.map {
                .init(
                    id: $0.id,
                    name: $0.name,
                    owner: $0.owner,
                    path: $0.path,
                    currentBranch: $0.currentBranch,
                    syncStatusRaw: $0.syncStatusRaw,
                    sortIndex: $0.sortIndex,
                    groupID: $0.group?.id,
                    selectedAccountID: $0.selectedAccount?.id
                )
            },
            groups: groups.map {
                .init(id: $0.id, name: $0.name, sortIndex: $0.sortIndex, isCollapsed: $0.isCollapsed)
            },
            accounts: accounts.map {
                .init(
                    id: $0.id,
                    username: $0.username,
                    host: $0.host,
                    avatarSystemImage: $0.avatarSystemImage
                )
            },
            preferences: preferences.map {
                .init(key: $0.key, valueJSON: $0.valueJSON)
            }
        )

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(snapshot)
    }

    static func decodeSnapshot(_ data: Data) throws -> Snapshot {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Snapshot.self, from: data)
    }
}
