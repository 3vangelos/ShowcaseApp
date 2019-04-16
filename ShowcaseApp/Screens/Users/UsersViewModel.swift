import Foundation
import RxCocoa
import RxSwift

class UsersViewModel {
    
    //MARK: Variables

    var usersSeq = BehaviorRelay<[User]>(value: [])
    var errorsSeq = BehaviorSubject<Error?>(value: nil)
    var isLoadingSeq = BehaviorSubject<Bool>(value: false)
    var numberOfCells: Int { return self.usersSeq.value.count }
    
    //MARK: Private Variables
    
    private let api: APIProtocol
    private let disposeBag = DisposeBag()
    
    //MARK: Init Method
    
    init(api: APIProtocol = API()) {
        self.api = api
    }
    
    //MARK: Public Methods
    
    func cellViewModelAtIndex(_ index: Int) -> UsersCellViewModel? {
        let user = self.usersSeq.value[index]
        return UsersCellViewModel(user)
    }
    
    func postsViewModelAtIndex(_ index: Int) -> PostsViewModel? {
        let user = self.usersSeq.value[index]
        return PostsViewModel(user: user, api: self.api)
    }

    func fetchData() {
        self.isLoadingSeq.onNext(true)
        self.api.getUsers()
            .subscribe(onNext: { users in
                self.usersSeq.accept(users)
            }, onError: { error in
                self.isLoadingSeq.onNext(false)
                self.errorsSeq.onNext(error)
            }, onCompleted: {
                self.isLoadingSeq.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
