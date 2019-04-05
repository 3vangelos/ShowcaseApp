import Foundation
import RxSwift

typealias StatusCode = Int

struct Request {
    
    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 20
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: configuration)
    }()
    
    static func data(_ request: URLRequest) -> Observable<(Data)> {
        return Observable<(Data)>.create { o in
            session.dataTask(with: request) { data, response, error in
                if let data = data {
                    o.onNext(data)
                    o.onCompleted()
                } else {
                    o.onError(APIError.createFromError(error: error, statusCode: response?.statusCode()))
                }
            }.resume()
            
            return Disposables.create()
        }
    }
}

extension URLResponse {
    func statusCode() -> StatusCode? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
