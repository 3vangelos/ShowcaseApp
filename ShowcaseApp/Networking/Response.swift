import Foundation
import RxSwift

struct Response {
    
    static func parse<T: Codable>(data: Data) -> Observable<T> {
        return Observable<T>.create { o in
            do {
                let decodedObject: T = try JSONDecoder().decode(T.self, from: data)
                o.onNext(decodedObject)
                o.onCompleted()
            } catch {
                o.onError(APIError.decoding)
            }
            
            return Disposables.create()
        }
    }
}
