import XCTest
@testable import ShowcaseApp

class UserViewModelTest: XCTestCase {
    
    var sut: UsersViewModel!
    var apiMock: APIMock!
    
    override func setUp() {
        super.setUp()
        apiMock = APIMock()
        sut = UsersViewModel(api: apiMock)
    }
    
    override func tearDown() {
        sut = nil
        apiMock = nil
        super.tearDown()
    }
    
    func testFetchUsers() {
        sut.fetchData()
        
        XCTAssert(apiMock!.isFetchDataCalled)
    }
    
    func testNumberOfUsers() {
        //Given
        apiMock.usersFetchSuccess()
        
        //When
        sut.fetchData()
        
        // Viemodel should now have all users from the stub
        XCTAssert(sut.numberOfCells == 10)
    }
    
    func testUserData() {
        apiMock.usersFetchSuccess()

        sut.fetchData()
        
        let userViewModel =  sut.cellViewModelAtIndex(0)
        XCTAssert(userViewModel?.name == "Leanne Graham")
        XCTAssert(userViewModel?.username == "Bret")
        XCTAssert(userViewModel?.email == "Sincere@april.biz")
        XCTAssert(userViewModel?.address == "Kulas Light, Apt. 556, Gwenborough, 92998-3874")
    }
    
    func testFailedToFetchUsers() {
        let someError = APIError.other
        apiMock.usersFetchFail(someError)

        sut.fetchData()
        
        XCTAssertEqual( sut.alertMessage, someError.message )
    }
}
