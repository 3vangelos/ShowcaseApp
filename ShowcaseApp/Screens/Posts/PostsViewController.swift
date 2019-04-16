import RxSwift
import UIKit

class PostsViewController: UIViewController {
    
    //MARK: Private Variables
    
    private let vm: PostsViewModel
    private lazy var postsView = TableView(cellClass: PostsTableViewCell.self, delegate: self)
    private lazy var disposeBag = DisposeBag()
    
    //MARK: Init Methods
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(nibName:bundle:) has not been implemented")
    }
    
    init(viewModel: PostsViewModel) {
        self.vm = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Posts"
    }
    
    //MARK: View LifeCycle
    
    override func loadView() {
        self.view = postsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.vm.isLoadingSeq
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { isLoading in
                self.postsView.isLoading = isLoading
            })
            .disposed(by: disposeBag)
        
        self.vm.postsSeq
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.postsView.reload()
            })
            .disposed(by: disposeBag)
        
        self.vm.errorsSeq
            .asObservable()
            .filter { $0 != nil }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
                self.showAlert((error as? APIError)?.message ?? "Error occured")
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.vm.fetchData()
    }
}

//MARK: TableViewDelegate & TableViewDataSource

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = self.vm.cellViewModelAtIndex(indexPath.row) else { return PostsTableViewCell() }
        
        let cell = PostsTableViewCell()
        cell.title = cellViewModel.title
        cell.body = cellViewModel.body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.numberOfCells
    }
}

//MARK: Private Helpers

extension PostsViewController {
    private func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
