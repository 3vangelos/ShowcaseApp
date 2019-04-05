import Foundation
import RxSwift

final class API: APIProtocol {
    
    func getUsers() -> Observable<[User]> {
        return Request.data(Resource.users.asURLRequest()).flatMap { data -> Observable<[User]> in
            return Response.parse(data: data)
        }
    }
    
    func getPostsByUserId(_ id: Int) -> Observable<[Post]> {
        return Request.data(Resource.posts(id).asURLRequest()).flatMap { data -> Observable<[Post]> in
            return Response.parse(data: data)
        }
    }
}
