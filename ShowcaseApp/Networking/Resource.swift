import Foundation

enum Resource {
    case users
    case posts(Int)
    
    private var baseUrlString: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    private var path: String {
        switch self {
        case .users: return "/users"
        case .posts: return "/posts"
        }
    }
    
    private var httpMethod: String {
        return "get"
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .posts(let id):
            return [URLQueryItem(name: "userId", value: String(id))]
        default: return nil
        }
    }
    
    private var url: URL {
        let url = baseUrlString + path
        
        var components = URLComponents(string: url)
        components?.queryItems = queryItems
        
        return URL(string: url)!
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = self.httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
}
