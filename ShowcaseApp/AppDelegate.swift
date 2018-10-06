import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let vc = UserListViewController()
        let nvc = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nvc
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
