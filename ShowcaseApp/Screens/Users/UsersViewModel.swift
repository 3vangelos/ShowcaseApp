import Foundation
import RxCocoa

class UsersViewModel {
    
    //MARK: Variables

    var users = BehaviorRelay<[User]>(value: [])
    var numberOfCells: Int {
        return self.users.value.count
    }
    
    //MARK: Private Variables
    
    private let api: APIProtocol
    
    //MARK: Init Method
    
    init(api: APIProtocol = API()) {
        self.api = api
    }
    
    //MARK: Public Methods
    
    func cellViewModelAtIndex(_ index: Int) -> UsersCellViewModel? {
        let user = self.users.value[index]
        return UsersCellViewModel(user)
    }
    
    func postsViewModelAtIndex(_ index: Int) -> PostsViewModel? {
        let user = self.users.value[index]
        return PostsViewModel(user: user, api: self.api)
    }
    
    func fetchData() {
        _ = api.getUsers().subscribe(onNext: { users in
            self.users.accept(users)
        })
    }
}
