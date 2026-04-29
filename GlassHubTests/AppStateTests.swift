import XCTest
@testable import GlassHub

@MainActor
final class AppStateTests: XCTestCase {
    func testInitialSelectionUsesFirstRepository() {
        let state = AppState(repositoryGroups: SampleData.repositoryGroups)
        XCTAssertEqual(state.selectedRepository?.name, "GlassHub")
    }

    func testSearchFiltersRepositoriesAcrossGroups() {
        let state = AppState(repositoryGroups: SampleData.repositoryGroups)
        state.searchText = "kpad"
        XCTAssertEqual(state.filteredGroups.flatMap(\.repositories).map(\.name), ["kampuspad"])
    }
}
