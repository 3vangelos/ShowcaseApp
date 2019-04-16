import RxSwift
import XCTest
@testable import ShowcaseApp

class APIMock: APIProtocol {
    func getUsers() -> Observable<[User]> {
        isFetchDataCalled = true
        return error != nil ? Observable.error(self.error!) : Observable.just(users ?? [])
    }
    
    func getPostsByUserId(_ id: Int) -> Observable<[Post]> {
        isFetchDataCalled = true
        return Observable.just([])
    }
    
    
    var isFetchDataCalled = false
    var users: [User]? = nil
    var error: APIError? = nil

    func usersFetchFail(_ error: APIError?) {
        self.error = error
    }
    
    func usersFetchSuccess() {
        self.users = readUsersFromStub()
    }
}


extension APIMock {
    func readUsersFromStub() -> [User] {
        if let path = Bundle(for: type(of: self)).path(forResource: "users", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let users = try! decoder.decode([User].self, from: data)
            return users
        } else {
            fatalError()
        }
    }
}
