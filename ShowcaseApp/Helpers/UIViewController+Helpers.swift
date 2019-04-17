import UIKit

extension UIViewController {
    
    func router() -> RouterContract? {
        return (UIApplication.shared.delegate as? AppDelegate)?.router
    }
}
