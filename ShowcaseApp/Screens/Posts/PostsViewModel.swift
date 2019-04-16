import Foundation
import RxCocoa
import RxSwift

final class PostsViewModel: ViewModel {
    
    //MARK: Private Variables
    
    private let user: User
    
    //MARK: Init Method
    
    init(user: User, api: APIProtocol) {
        self.user = user
        super.init(api: api)
    }
    
    //MARK: Public Methods

    func cellViewModelAtIndex(_ index: Int) -> PostCellViewModel? {
        guard let post = self.modelArraySeq.value[index] as? Post else { return nil }
        return PostCellViewModel(post)
    }
    
    func fetchData() {
        self.isLoadingSeq.onNext(true)
        self.api.getPostsByUserId(self.user.id)
            .subscribe(onNext: { posts in
                self.modelArraySeq.accept(posts)
            }, onError: { error in
                self.isLoadingSeq.onNext(false)
                self.errorSeq.onNext(error)
            }, onCompleted: {
                self.isLoadingSeq.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
