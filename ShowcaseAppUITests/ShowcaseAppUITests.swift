import XCTest

class ShowcaseAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    var tablesQuery: XCUIElementQuery!
    
    override func setUp() {

        app = XCUIApplication()
        tablesQuery = app.tables
        
        continueAfterFailure = false
        app.launch()
        
        XCUIDevice.shared.orientation = .portrait
    }

    override func tearDown() {
        tablesQuery = nil
        app = nil
    }

    func testNavigationToDetailFromFirstCell() {
        tablesQuery.cells.firstMatch.tap()
    }

    func testNavigationBackFromDetailScreen() {
        tablesQuery.cells.firstMatch.tap()
        let usersButton = app.navigationBars.firstMatch.buttons.firstMatch
        usersButton.tap()
    }
    
    func testUIFlowAfterOrientationChange() {
        XCUIDevice.shared.orientation = .landscapeLeft
        tablesQuery.cells.firstMatch.tap()
        let usersButton = app.navigationBars.firstMatch.buttons.firstMatch
        usersButton.tap()
    }
}
