import Foundation
import RxCocoa
import RxSwift

final class UsersViewModel: ViewModel {
    
    //MARK: Init Method
    
    override init(api: APIProtocol) {
        super.init(api: api)
    }

    //MARK: Public Methods
    
    func cellViewModelAtIndex(_ index: Int) -> UsersCellViewModel? {
        guard let user = self.modelArraySeq.value[index] as? User else { return nil }
        return UsersCellViewModel(user)
    }
    
    func userAtIndex(_ index: Int) -> User? {
        return self.modelArraySeq.value[index] as? User
    }

    func fetchData() {
        self.isLoadingSeq.onNext(true)
        self.api.getUsers()
            .subscribe(onNext: { users in
                self.modelArraySeq.accept(users)
            }, onError: { error in
                self.isLoadingSeq.onNext(false)
                self.errorSeq.onNext(error)
            }, onCompleted: {
                self.isLoadingSeq.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
