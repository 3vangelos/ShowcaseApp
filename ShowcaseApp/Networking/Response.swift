import Foundation

struct Response {
    
    static func parse<T: Codable>(statusCode: StatusCode?, data: Data?, error: NSError?, _ completion: @escaping (T?, APIError?) -> Void) {
        
        if let error = APIError.apiServiceErrorForHTTPStatus(statusCode: statusCode, errorCode: error?.code) {
            completion(nil, error)
        } else if let data = data {
            do {
                let decoder = JSONDecoder()
                let decodedObject: T = try decoder.decode(T.self, from: data)
                completion(decodedObject, nil)
            } catch {
                completion(nil, .decoding)
            }
        } else {
            completion(nil, .other)
        }
    }
}
