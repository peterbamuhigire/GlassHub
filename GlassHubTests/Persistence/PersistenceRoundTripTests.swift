import XCTest
import SwiftData
@testable import GlassHub

@MainActor
final class PersistenceRoundTripTests: XCTestCase {
    private var controller: PersistenceController!

    override func setUp() async throws {
        controller = PersistenceController.inMemory()
    }

    override func tearDown() async throws {
        controller = nil
    }

    func testRepositorySurvivesContextReload() throws {
        let firstContext = ModelContext(controller.container)
        let group = StoredRepositoryGroup(name: "Personal", sortIndex: 0)
        firstContext.insert(group)

        let repo = StoredRepository(
            name: "GlassHub",
            owner: "byoosi",
            path: "/Users/test/Sites/GlassHub",
            currentBranch: "main",
            syncStatusRaw: "Synced",
            sortIndex: 0,
            group: group
        )
        firstContext.insert(repo)
        try firstContext.save()

        let secondContext = ModelContext(controller.container)
        let fetched = try secondContext.fetch(FetchDescriptor<StoredRepository>())
        XCTAssertEqual(fetched.count, 1)
        XCTAssertEqual(fetched.first?.name, "GlassHub")
        XCTAssertEqual(fetched.first?.group?.name, "Personal")
    }

    func testInvalidatingCachesDeletesCommitsAndAnalytics() async throws {
        let actor = PersistenceActor(modelContainer: controller.container)
        _ = try await actor.upsertRepository(
            path: "/tmp/repo",
            name: "Repo",
            owner: "octocat",
            currentBranch: "main",
            syncStatusRaw: "Synced"
        )

        let setupContext = ModelContext(controller.container)
        let repo = try XCTUnwrap(
            try setupContext.fetch(
                FetchDescriptor<StoredRepository>(
                    predicate: #Predicate { $0.path == "/tmp/repo" }
                )
            ).first
        )
        let cache = StoredCommitCache(
            sha: "abc1234",
            subject: "Initial commit",
            message: "Initial commit",
            author: "octocat",
            date: .now,
            additions: 1,
            deletions: 0,
            repository: repo
        )
        let snapshot = StoredAnalyticsSnapshot(
            weekStart: .now,
            commits: 1,
            additions: 1,
            deletions: 0,
            repository: repo
        )
        setupContext.insert(cache)
        setupContext.insert(snapshot)
        try setupContext.save()

        try await actor.invalidateCaches(forRepositoryPath: "/tmp/repo")

        let verifyContext = ModelContext(controller.container)
        let caches = try verifyContext.fetch(FetchDescriptor<StoredCommitCache>())
        let snapshots = try verifyContext.fetch(FetchDescriptor<StoredAnalyticsSnapshot>())
        XCTAssertTrue(caches.isEmpty)
        XCTAssertTrue(snapshots.isEmpty)
    }

    func testPreferenceUpsertByKey() throws {
        let context = ModelContext(controller.container)
        let pref = StoredPreference(key: "sidebar.lastSelectedRepoID", valueJSON: Data("\"abc\"".utf8))
        context.insert(pref)
        try context.save()

        let fetched = try context.fetch(
            FetchDescriptor<StoredPreference>(
                predicate: #Predicate { $0.key == "sidebar.lastSelectedRepoID" }
            )
        )
        XCTAssertEqual(fetched.count, 1)
    }
}
