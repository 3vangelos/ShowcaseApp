import Foundation

final class API: APIProtocol {
    
    func getUsers(_ completion: @escaping ([User]?, APIError?) -> Void) {
        let resource = Resource.users
        Request.data(resource.asURLRequest()) { statusCode, data, error in
            Response.parse(statusCode: statusCode, data: data, error: error as NSError?, completion)
        }
    }
}
