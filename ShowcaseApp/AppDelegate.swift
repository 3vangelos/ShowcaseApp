import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // let it crash if storybaord scenes not set up properly!
        let nvc = window!.rootViewController as! UINavigationController
        let vc = nvc.topViewController as! UsersViewController
        vc.vm = UsersViewModel()

        return true
    }
}

