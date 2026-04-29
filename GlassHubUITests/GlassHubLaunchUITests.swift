import XCTest

final class GlassHubLaunchUITests: XCTestCase {
    func testAppLaunchesToRepositoryShell() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.windows.firstMatch.waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["GlassHub"].exists)
    }
}
