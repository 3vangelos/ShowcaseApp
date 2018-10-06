import XCTest
@testable import ShowcaseApp

class APITests: XCTestCase {
    
    var sut: API!
    
    override func setUp() {
        super.setUp()
        sut = API()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    func testAsynchronousUsersAPI() {
        let expectation = self.expectation(description: "Fetch Users")
        var users: [User] = []
        
        sut.getUsers { u, e in
            guard let u = u else { return }
            users = u
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertGreaterThan(users.count, 0)
    }
}
