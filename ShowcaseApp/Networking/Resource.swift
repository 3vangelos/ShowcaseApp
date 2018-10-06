import Foundation

enum Resource {
    case users
    
    private var baseUrlString: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    private var path: String {
        switch self {
        case .users: return "/users"
        }
    }
    
    private var httpMethod: String {
        return "get"
    }
    
    private var url: URL {
        let url = baseUrlString + path
        return URL(string: url)!
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = self.httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
}
