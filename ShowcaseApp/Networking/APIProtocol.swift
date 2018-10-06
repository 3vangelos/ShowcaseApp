import Foundation

protocol APIProtocol {
    
    func getUsers(_ completion: @escaping ([User]?, APIError?) -> Void)
    
}
