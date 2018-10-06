import Foundation

class PostsViewModel {
    
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
        return posts.count
    }
    
    func cellViewModelAtIndex(_ index: Int) -> PostCellViewModel? {
        let post = self.posts[index]
        return PostCellViewModel(post)
    }
    
    private var posts: [Post] = [] {
        didSet {
            self.reloadViewClosure?()
        }
    }
    
    private let user: User
    
    init(user: User, api: API) {
        self.api = api
        self.user = user
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
