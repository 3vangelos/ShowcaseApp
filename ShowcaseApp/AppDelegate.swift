import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    let api: APIProtocol = API()
    lazy var router: RouterContract =  Router(window: window!, api: api)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        router.presentUserList()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
