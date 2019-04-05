import RxSwift

protocol APIProtocol {
    
    func getUsers() -> Observable<[User]>
    
    func getPostsByUserId(_ id: Int) -> Observable<[Post]>
}
