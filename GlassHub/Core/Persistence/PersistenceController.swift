import Foundation
import SwiftData

/// Owns the SwiftData `ModelContainer` for GlassHub.
///
/// Use `PersistenceController.shared` for the on-disk store and
/// `PersistenceController.inMemory()` in tests / previews.
@MainActor
final class PersistenceController {
    static let shared = PersistenceController()

    let container: ModelContainer

    private init(inMemory: Bool = false, url: URL? = nil) {
        let schema = Schema(versionedSchema: SchemaV1.self)
        let configuration: ModelConfiguration
        if inMemory {
            configuration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: true
            )
        } else if let url {
            configuration = ModelConfiguration(schema: schema, url: url)
        } else {
            configuration = ModelConfiguration(schema: schema)
        }

        do {
            container = try ModelContainer(
                for: schema,
                migrationPlan: GlassHubMigrationPlan.self,
                configurations: configuration
            )
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error)")
        }
    }

    static func inMemory() -> PersistenceController {
        PersistenceController(inMemory: true)
    }

    static func temporary(url: URL) -> PersistenceController {
        PersistenceController(inMemory: false, url: url)
    }
}
