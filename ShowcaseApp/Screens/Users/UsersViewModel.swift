import Foundation

class UsersViewModel {
    
    let api: API
    
    // Binding Closures
    
    var reloadViewClosure: (()->())?
    var showAlertClosure: (()->())?
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return users.count
    }
    
    func cellViewModelAtIndex(_ index: Int) -> UsersCellViewModel? {
        let user = self.users[index]
        return UsersCellViewModel(user)
    }
    
    func postsViewModelAtIndex(_ index: Int) -> PostsViewModel? {
        let user = self.users[index]
        return PostsViewModel(user: user, api: self.api)
    }
    
    
    private var users: [User] = [] {
        didSet {
            self.reloadViewClosure?()
        }
    }
    
    init(api: API = API()) {
        self.api = api
    }
    
    func fetchData() {
        api.getUsers { users, error in
            if let error = error {
                self.alertMessage = error.message
            } else if let users = users {
                self.users = users
            }
        }
    }
}