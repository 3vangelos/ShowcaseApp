import Foundation
import RxCocoa

class PostsViewModel {

    //MARK: Variables
    
    var posts = BehaviorRelay<[Post]>(value: [])
    var numberOfCells: Int {
        return self.posts.value.count
    }
    
    //MARK: Private Variables
    
    private let user: User
    private let api: APIProtocol
    
    //MARK: Init Method
    
    init(user: User, api: APIProtocol) {
        self.api = api
        self.user = user
    }
    
    //MARK: Public Methods

    func cellViewModelAtIndex(_ index: Int) -> PostCellViewModel? {
        let post = self.posts.value[index]
        return PostCellViewModel(post)
    }
    
    func fetchData() {
        _ = api.getPostsByUserId(self.user.id).subscribe(onNext: { posts in
            self.posts.accept(posts)
        })
        
    }
}
