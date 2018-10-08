import Foundation

class UsersViewModel {
    
    //MARK: Variables
    
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
    
    //MARK: Private Variables
    
    private let api: APIProtocol
    private var users: [User] = [] {
        didSet {
            self.reloadViewClosure?()
        }
    }
    
    //MARK: Init Method
    
    init(api: APIProtocol = API()) {
        self.api = api
    }
    
    //MARK: Public Methods
    
    func cellViewModelAtIndex(_ index: Int) -> UsersCellViewModel? {
        let user = self.users[index]
        return UsersCellViewModel(user)
    }
    
    func postsViewModelAtIndex(_ index: Int) -> PostsViewModel? {
        let user = self.users[index]
        return PostsViewModel(user: user, api: self.api)
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
