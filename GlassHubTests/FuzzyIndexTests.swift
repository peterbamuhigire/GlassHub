import XCTest
@testable import GlassHub

final class FuzzyIndexTests: XCTestCase {
    func testContiguousMatch() {
        XCTAssertTrue(FuzzyIndex.matches(needle: "hub", haystack: "GlassHub"))
    }

    func testAbbreviationMatch() {
        XCTAssertTrue(FuzzyIndex.matches(needle: "kpad", haystack: "kampuspad"))
    }

    func testMissingCharactersDoNotMatch() {
        XCTAssertFalse(FuzzyIndex.matches(needle: "xyz", haystack: "GlassHub"))
    }
}
