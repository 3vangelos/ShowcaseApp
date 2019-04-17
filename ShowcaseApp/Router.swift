import UIKit

protocol RouterContract {
    
    func presentUserList()
    func presentPosts(of user: User)
}

final class Router {
    
    // MARK: - Private Variables
    
    private weak var window: UIWindow?
    private let api: APIProtocol
    
    private var nvc: UINavigationController? {
        return self.window?.rootViewController as? UINavigationController
    }

    // MARK: - Init Methods
    
    init(window: UIWindow, api: APIProtocol) {
        self.window = window
        self.api = api
    }
}

extension Router: RouterContract {
    
    func presentUserList() {
        let vc = UsersViewController()
        vc.vm = UsersViewModel(api: self.api)
        let nvc = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nvc        
    }
    
    func presentPosts(of user: User) {
        let vm = PostsViewModel(user: user, api: self.api)
        let vc = PostsViewController(viewModel: vm)
        self.nvc?.pushViewController(vc, animated: true)
    }
}
