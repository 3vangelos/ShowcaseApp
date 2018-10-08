import Foundation

protocol APIProtocol {
    
    func getUsers(_ completion: @escaping ([User]?, APIError?) -> Void)
    
    func getPostsByUserId(_ id: Int, _ completion: @escaping ([Post]?, APIError?) -> Void)
}
