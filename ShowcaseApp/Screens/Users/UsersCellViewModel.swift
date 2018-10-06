import Foundation


struct UsersCellViewModel {
    
    //MARK: Variables
    
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
    
    //MARK: Private Variables
    
    private let user: User
    
    //MARK: Init Methods
    
    init(_ user: User) {
        self.user = user
    }
}
