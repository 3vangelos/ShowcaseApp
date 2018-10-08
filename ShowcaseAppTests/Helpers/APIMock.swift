import XCTest
@testable import ShowcaseApp

class APIMock: APIProtocol {
    
    var isFetchDataCalled = false
    var users: [User]? = nil
    var error: APIError? = nil
    
    var usersCompleteFetch: (([User]?, APIError?) -> Void)!
    var postsCompleteFetch: (([Post]?, APIError?) -> Void)!
    
    func getUsers(_ completion: @escaping ([User]?, APIError?) -> Void) {
        isFetchDataCalled = true
        completion(users, error)
    }
    
    func getPostsByUserId(_ id: Int, _ completion: @escaping ([Post]?, APIError?) -> Void) {
        isFetchDataCalled = true
    }

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
