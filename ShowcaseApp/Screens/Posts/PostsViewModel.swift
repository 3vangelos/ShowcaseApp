import Foundation

class PostsViewModel {

    //MARK: Variables
    
    var reloadViewClosure: (()->())?
    var showAlertClosure: (()->())?
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return posts.count
    }
    
    //MARK: Private Variables
    
    private let user: User
    private let api: APIProtocol
    private var posts: [Post] = [] {
        didSet {
            self.reloadViewClosure?()
        }
    }
    
    //MARK: Init Method
    
    init(user: User, api: APIProtocol) {
        self.api = api
        self.user = user
    }
    
    //MARK: Public Methods
    
    func cellViewModelAtIndex(_ index: Int) -> PostCellViewModel? {
        let post = self.posts[index]
        return PostCellViewModel(post)
    }
    
    func fetchData() {
        api.getPostsByUserId(self.user.id) { posts, error in
            if let error = error {
                self.alertMessage = error.message
            } else if let posts = posts {
                self.posts = posts
            }
        }
    }
}
