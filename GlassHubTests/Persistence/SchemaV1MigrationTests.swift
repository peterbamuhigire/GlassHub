import XCTest
import SwiftData
@testable import GlassHub

/// Migration smoke tests.
///
/// V1 is the inaugural schema, so there is nothing to migrate from. These tests seed a
/// V1 store on disk, then re-open it through the production migration plan to assert
/// that the plan can load existing-data stores without loss. When V2 ships, add a
/// dedicated test that seeds V1 and verifies the V1→V2 stage.
final class SchemaV1MigrationTests: XCTestCase {
    private var temporaryDirectory: URL!

    override func setUpWithError() throws {
        temporaryDirectory = FileManager.default.temporaryDirectory
            .appendingPathComponent("glasshub-migration-tests-\(UUID().uuidString)", isDirectory: true)
        try FileManager.default.createDirectory(
            at: temporaryDirectory,
            withIntermediateDirectories: true
        )
    }

    override func tearDownWithError() throws {
        if let temporaryDirectory {
            try? FileManager.default.removeItem(at: temporaryDirectory)
        }
    }

    @MainActor
    func testSeededV1StoreOpensThroughMigrationPlan() throws {
        let storeURL = temporaryDirectory.appendingPathComponent("seed.store")

        // Seed: write a V1 store directly.
        do {
            let schema = Schema(versionedSchema: SchemaV1.self)
            let configuration = ModelConfiguration(schema: schema, url: storeURL)
            let container = try ModelContainer(for: schema, configurations: configuration)
            let context = ModelContext(container)
            let group = StoredRepositoryGroup(name: "Seeded", sortIndex: 0)
            context.insert(group)
            let repo = StoredRepository(
                name: "Seed",
                owner: "octocat",
                path: "/tmp/seed",
                currentBranch: "main",
                syncStatusRaw: "Synced",
                group: group
            )
            context.insert(repo)
            try context.save()
        }

        // Re-open via the production migration plan.
        let schema = Schema(versionedSchema: SchemaV1.self)
        let configuration = ModelConfiguration(schema: schema, url: storeURL)
        let container = try ModelContainer(
            for: schema,
            migrationPlan: GlassHubMigrationPlan.self,
            configurations: configuration
        )
        let context = ModelContext(container)
        let repos = try context.fetch(FetchDescriptor<StoredRepository>())
        XCTAssertEqual(repos.count, 1)
        XCTAssertEqual(repos.first?.group?.name, "Seeded")
    }
}
