import Foundation


class UsersCellViewModel {
    
    var name: String? {
        return self.user.name
    }
    
    var username: String? {
        return self.user.username
    }
    
    var email: String? {
        return self.user.email
    }
    
    var address: String? {
        return self.user.address?.concatenated()
    }
    
    private let user: User
    
    init(_ user: User) {
        self.user = user
    }
}
