import Foundation
import RxSwift

final class API: APIProtocol {
    
    private let fileHandler = FileHandler()
    
    func getUsers() -> Observable<[User]> {
        let fileName = "users"
        return FileHandler().read(from: fileName).catchError { _ in
            return Request.data(Resource.users.asURLRequest()).flatMap { data -> Observable<[User]> in
                self.fileHandler.write(data, to: fileName)
                return Response.parse(data: data)
            }
        }
    }
    
    func getPostsByUserId(_ id: Int) -> Observable<[Post]> {
        let fileName = "\(id)"
        return FileHandler().read(from: fileName).catchError { _ in
            return Request.data(Resource.posts(id).asURLRequest()).flatMap { data -> Observable<[Post]> in
                self.fileHandler.write(data, to: fileName)
                return Response.parse(data: data)
            }
        }
    }
}
