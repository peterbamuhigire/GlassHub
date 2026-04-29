import XCTest
import SwiftData
@testable import GlassHub

/// Guards against accidental persistence of OAuth tokens or other secret material in
/// the SwiftData store. Acceptance criterion (phase 03):
/// "No OAuth token or secret appears in SwiftData files."
final class PersistenceSecretLeakTests: XCTestCase {
    @MainActor
    func testStoredAccountReferenceHasNoSecretFields() throws {
        // Smoke check: the model is intentionally minimal. Adding token, refreshToken,
        // password, or clientSecret here would trip this test by appearing in the
        // exported snapshot keys.
        let controller = PersistenceController.inMemory()
        let context = ModelContext(controller.container)
        let account = StoredAccountReference(
            username: "octocat",
            host: "github.com",
            avatarSystemImage: "person.crop.circle",
            keychainAccount: "lookup-key-1"
        )
        context.insert(account)
        try context.save()

        let data = try PersistenceDebugTools.export(from: context)
        let json = String(data: data, encoding: .utf8) ?? ""

        let forbiddenSubstrings = [
            "\"token\"",
            "\"accessToken\"",
            "\"refreshToken\"",
            "\"password\"",
            "\"clientSecret\"",
            "\"keychainAccount\""
        ]
        for needle in forbiddenSubstrings {
            XCTAssertFalse(
                json.contains(needle),
                "Persistence dump contained forbidden key \(needle)"
            )
        }
    }

    @MainActor
    func testDebugExportRoundTripsSnapshotShape() throws {
        let controller = PersistenceController.inMemory()
        let context = ModelContext(controller.container)
        context.insert(StoredRepositoryGroup(name: "Group A"))
        try context.save()

        let data = try PersistenceDebugTools.export(from: context)
        let snapshot = try PersistenceDebugTools.decodeSnapshot(data)
        XCTAssertEqual(snapshot.groups.count, 1)
        XCTAssertEqual(snapshot.groups.first?.name, "Group A")
    }
}
