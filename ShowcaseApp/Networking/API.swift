import Foundation
import RxSwift

final class API: APIProtocol {
    
    func getUsers() -> Observable<[User]> {
        return FileHandler().read(from: "users").catchError { _ in
            return Request.data(Resource.users.asURLRequest()).flatMap { data in
                return Response.parse(data: data, to: "users")
            }
        }
    }
    
    func getPostsByUserId(_ id: Int) -> Observable<[Post]> {
        return FileHandler().read(from: "\(id)").catchError { _ in
            return Request.data(Resource.posts(id).asURLRequest()).flatMap { data in
                return Response.parse(data: data, to: "\(id)")
            }
        }
    }
}
