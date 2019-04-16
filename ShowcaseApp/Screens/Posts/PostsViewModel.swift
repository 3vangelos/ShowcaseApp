import Foundation
import RxCocoa
import RxSwift

class PostsViewModel {

    //MARK: Variables
    
    var postsSeq = BehaviorRelay<[Post]>(value: [])
    var errorsSeq = BehaviorSubject<Error?>(value: nil)
    var isLoadingSeq = BehaviorSubject<Bool>(value: false)
    var numberOfCells: Int { return self.postsSeq.value.count }
    
    //MARK: Private Variables
    
    private let user: User
    private let api: APIProtocol
    private let disposeBag = DisposeBag()
    
    //MARK: Init Method
    
    init(user: User, api: APIProtocol) {
        self.api = api
        self.user = user
    }
    
    //MARK: Public Methods

    func cellViewModelAtIndex(_ index: Int) -> PostCellViewModel? {
        let post = self.postsSeq.value[index]
        return PostCellViewModel(post)
    }
    
    func fetchData() {
        self.isLoadingSeq.onNext(true)
        self.api.getPostsByUserId(self.user.id)
            .subscribe(onNext: { posts in
                self.postsSeq.accept(posts)
            }, onError: { error in
                self.isLoadingSeq.onNext(false)
                self.errorsSeq.onNext(error)
            }, onCompleted: {
                self.isLoadingSeq.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
