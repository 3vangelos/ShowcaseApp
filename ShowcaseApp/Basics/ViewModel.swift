import Foundation
import RxCocoa
import RxSwift

class ViewModel {
    
    //MARK: Variables
    
    var modelArraySeq = BehaviorRelay<[Codable]>(value: [])
    var errorSeq = BehaviorSubject<Error?>(value: nil)
    var isLoadingSeq = BehaviorSubject<Bool>(value: false)
    var numberOfCells: Int { return self.modelArraySeq.value.count }
    
    let api: APIProtocol
    let disposeBag = DisposeBag()
    
    //MARK: Init Method
    
    init(api: APIProtocol = API()) {
        self.api = api
    }
}
