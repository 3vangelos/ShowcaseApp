import Foundation

struct PostCellViewModel {
    
    var title: String? {
        return self.post.title
    }
    
    var body: String? {
        return self.post.body
    }
    
    private let post: Post
    
    init(_ post: Post) {
        self.post = post
    }
}
