import Foundation
import SwiftData

enum SchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version { Schema.Version(1, 0, 0) }

    static var models: [any PersistentModel.Type] {
        [
            StoredRepository.self,
            StoredRepositoryGroup.self,
            StoredAccountReference.self,
            StoredCommitCache.self,
            StoredAnalyticsSnapshot.self,
            StoredPreference.self
        ]
    }
}

enum GlassHubMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [SchemaV1.self]
    }

    static var stages: [MigrationStage] {
        []
    }
}
